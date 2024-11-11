//
// Created by 高峻峰 on 2024/1/9.
//
#ifndef TSRSDK_IOS_TSRPASS_H
#define TSRSDK_IOS_TSRPASS_H

#import <Metal/Metal.h>
#import <simd/simd.h>
#import <AVFoundation/AVFoundation.h>

/*!
 * @brief Enum representing various initialization errors for TSRPass.
 *
 * TSRInitStatusCodeSuccess -> Initialization was successful.
 *
 * TSRInitStatusCodeMetalInitFailed -> Metal initialization failed, fallback to normal playback.
 *
 * TSRInitStatusCodeSDKLicenseStatusNotAvailable -> SDK license verification failed or was not verified, fallback to normal playback.
 *
 * TSRInitStatusCodeAlgorithmTypeInvalid -> The initialization parameter TSRAlgorithmType is invalid, fallback to normal playback.
 *
 * TSRInitStatusCodeMLModelInitFailed -> Machine learning model module initialization failed, fallback to TSRAlgorithmType.STANDARD.
 * 
 * TSRInitStatusCodeInputResolutionInvalid -> The input resolution is invalid; it must be between 1 to 4096.
 */
typedef NS_ENUM(NSInteger, TSRInitStatusCode) {
    TSRInitStatusCodeSuccess = 0,
    TSRInitStatusCodeMetalInitFailed = -10001,
    TSRInitStatusCodeSDKLicenseStatusNotAvailable = -10002,
    TSRInitStatusCodeAlgorithmTypeInvalid = -10003,
    TSRInitStatusCodeMLModelInitFailed = -10004,
    TSRInitStatusCodeInputResolutionInvalid = -10005
};

/*!
 * @brief The TSRAlgorithmType enum value representing the algorithm running mode to be used.
 *
 * TSRAlgorithmTypeStandard -> The TSRAlgorithmTypeStandard mode provides fast super-resolution processing speed, suitable for scenarios with high real-time requirements. It can achieve significant image quality improvements while prioritizing performance.
 *
 * TSRAlgorithmTypeProfessional -> Deprecated. Currently equivalent to TSRAlgorithmTypeProfessionalHighQuality. Only available on iOS 15.0 or newer.
 *
 * TSRAlgorithmTypeProfessionalHighQuality -> The TSRAlgorithmTypeProfessionalHighQuality mode ensures high image quality while requiring higher device performance. It is suitable for scenarios with high image quality requirements and is recommended for use on mid-to-high-end smartphones. Only available on iOS 16.0 or newer.
 *
 * TSRAlgorithmTypeProfessionalFast -> The TSRAlgorithmTypeProfessionalFast mode ensures faster processing speed while sacrificing some image quality. It is suitable for scenarios with high real-time requirements and is recommended for use on mid-range smartphones. Only available on iOS 15.0 or newer.
 */
typedef NS_ENUM(NSInteger, TSRAlgorithmType) {
    TSRAlgorithmTypeStandard,
    TSRAlgorithmTypeProfessional API_AVAILABLE(ios(15.0)) __attribute__((deprecated("Use TSRAlgorithmTypeProfessionalHighQuality or TSRAlgorithmTypeProfessionalFast instead."))),
    TSRAlgorithmTypeProfessionalHighQuality API_AVAILABLE(ios(16.0)),
    TSRAlgorithmTypeProfessionalFast API_AVAILABLE(ios(15.0)),
};

/*!
 * The TSRPass class provides methods for performing super-resolution rendering on input images using the Metal framework.
 *
 * TSRPass is responsible for initializing the super-resolution rendering process with the specified input image size and super-resolution ratio. It also provides a render method that applies the super-resolution process to
 * the input image and returns the processed image as an MTLTexture object.
 *
 * <p><b>Note: </b></p>
 * 1. This class uses the Metal framework for performing super-resolution rendering and requires a device that supports Metal.
 * 2. All methods of TSRPass must be called within the same thread.
 * 3. The render:commandBuffer: and renderWithPixelBuffer: method should not be called before the initWithTSRAlgorithmType:device:inputWidth:inputHeight:srRatio:initStatusCode: method, and it should not be called after the deInit method.
 * 4. Initializing the TSRPass with TSRAlgorithmTypeProfessional is only available on iOS 15.0 or newer. If the iOS version is older, it will fallback to TSRAlgorithmTypeStandard.
 *
 * <p><b>Usage: </b></p>
 * 1. Create a TSRPass instance using the initWithTSRAlgorithmType:device:inputWidth:inputHeight:srRatio:initStatusCode: method.
 * 2. Call the render:commandBuffer: method with the input image's MTLTexture and an MTLCommandBuffer to perform super-resolution rendering.
 * 3. Obtain the processed image as an MTLTexture from the return value of the render:commandBuffer: method.
 * 4. deInit method should be called when the TSRPass object is no longer needed, to free up the memory and other resources.
 */
@interface TSRPass: NSObject

/*!
 * Init TSRPass object for super-resolution.
 *
 * @param algorithmType The TSRAlgorithmType enum value representing the algorithm running mode to be used. It can be either STANDARD (fast mode) or PROFESSIONAL (quality mode). STANDARD mode prioritizes better performance in terms of speed, possibly sacrificing some result accuracy. PROFESSIONAL mode prioritizes result accuracy, even if the running speed is slower.
 * @param device The MTLDevice which you are using.
 * @param inputWidth The width of the input texture. This value should be between 1 to 4096.
 * @param inputHeight The height of the input texture. This value should be between 1 to 4096.
 * @param srRatio The magnification factor for super-resolution.
 * @param initStatusCode A pointer to a TSRInitStatusCode enum value that will store the result of the initialization process. If initialization is successful, the value will be TSRInitStatusCodeSuccess. If initialization fails, the value will indicate the specific error that occurred.
 */
- (instancetype)initWithTSRAlgorithmType:(TSRAlgorithmType)algorithmType device:(id<MTLDevice>)device inputWidth:(int32_t)inputWidth inputHeight:(int32_t)inputHeight srRatio:(float_t)srRatio initStatusCode:(TSRInitStatusCode*)initStatusCode;

/**
 * Reinitializes the TSRPass object for super-resolution rendering. The input parameters specify the new dimensions of the input image to be processed and the new magnification factor for super-resolution.
 *
 * @param inputWidth  The new width of the input image to be processed. This value should be between [1, 4096].
 * @param inputHeight The new height of the input image to be processed. This value should be between [1, 4096].
 * @param srRatio     The new magnification factor for super-resolution. This value should be greater than zero and determines the scaling applied to the input image during the rendering process.
 * @return TSRInitStatusCode enum value that will store the result of the reinitialization process. If reinitialization is successful, the value will be TSRInitStatusCodeSuccess. If reinitialization fails, the value will indicate the specific error that occurred.
 */
- (TSRInitStatusCode) reInit:(int32_t)inputWidth inputHeight: (int32_t)inputHeight srRatio:(float_t)srRatio;

/*!
 * Performs the super-resolution rendering operation on the input image.
 * <br>
 * This method applies the super-resolution rendering process to the input image, improving its quality. The processed image is rendered onto a MTLTexture within
 * the TSRPass object. And the return is the MTLTexture which has preformed super-resolution rendering .
 * <br>
 *
 * @param texture The MTLTexture of the input image that needs to be processed for super-resolution.
 * @param commandBuffer The MTLCommandBuffer which you are using.
 * @return The MTLTexture that will be performed super-resolution rendering, which is stored inside the TSRPass
 * object. The size of the output texture is (inputWidth * srRatio, inputHeight * srRatio).
 */
- (id<MTLTexture>)render:(id<MTLTexture>)texture commandBuffer:(id<MTLCommandBuffer>)commandBuffer;

/*!
 * Performs the super-resolution rendering operation on the input pixel buffer.
 *
 * This method applies the super-resolution rendering process to the input pixel buffer, improving its quality. The processed pixel buffer is created and returned as a new CVPixelBufferRef.
 *
 * @note The SDK internally handles the lifecycle of the returned CVPixelBufferRef, therefore, the caller absolutely should not attempt to manually release the returned CVPixelBufferRef.
 *
 * @param pixelBuffer The CVPixelBufferRef of the input image that needs to be processed for super-resolution. The width and height of the pixel buffer must match the inputWidth and inputHeight set during initialization, and the pixel format must be BGRA.
 * @return The CVPixelBufferRef that has been performed super-resolution rendering. The size of the output pixel buffer is (inputWidth * srRatio, inputHeight * srRatio).
 */
- (CVPixelBufferRef)renderWithPixelBuffer:(CVPixelBufferRef)pixelBuffer;

/**
 * Adjusts the parameters of the rendering operator.
 * It needs to take effect after TSRPass#initWithDevice is called.
 *
 * @param brightness The brightness level to apply.
 *                   Valid values are between 0 and 100, with a default value of 50.
 * @param saturation The saturation level to apply.
 *                   Valid values are between 0 and 100, with a default value of 50.
 * @param contrast   The contrast level to apply.
 *                   Valid values are between 0 and 100, with a default value of 50.
 * @param sharpness  The sharpness level to apply.
 *                   Valid values are between 0 and 100, with a default value of 0.
 */
- (void)setParametersWithBrightness:(float)brightness saturation:(float)saturation contrast:(float)contrast sharpness:(float)sharpness;

/**
 * Releases the resources.
 * <br>
 * This method should be called when the TSRPass object is no longer needed, to free up the memory and other resources.
 */
- (void)deInit;

@end

#endif

