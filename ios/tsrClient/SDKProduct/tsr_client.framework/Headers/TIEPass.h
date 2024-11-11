//
//  TIEPass.h
//  tsr-client
//
//  Created by Junfeng Gao on 2024/5/13.
//

#ifndef TIEPass_h
#define TIEPass_h

#import <Metal/Metal.h>
#import <simd/simd.h>
#import <AVFoundation/AVFoundation.h>

/*!
 * @brief Enum representing various initialization errors for TIEPass.
 *
 * TIEInitStatusCodeSuccess -> Initialization was successful.
 *
 * TIEInitStatusCodeMetalInitFailed -> Metal initialization failed, fallback to normal playback.
 *
 * TIEInitStatusCodeSDKLicenseStatusNotAvailable -> SDK license verification failed or was not verified, fallback to normal playback.
 *
 * TIEInitStatusCodeAlgorithmTypeInvalid -> The initialization parameter TIEAlgorithmType is invalid, fallback to normal playback.
 *
 * TIEInitStatusCodeMLModelInitFailed -> Machine learning model module initialization failed, fallback to normal playback.
 *
 * TIEInitStatusCodeInputResolutionInvalid -> The input resolution is invalid; it must be between 1 to 4096.
 */
typedef NS_ENUM(NSInteger, TIEInitStatusCode) {
    TIEInitStatusCodeSuccess = 0,
    TIEInitStatusCodeMetalInitFailed = -11001,
    TIEInitStatusCodeSDKLicenseStatusNotAvailable = -11002,
    TIEInitStatusCodeAlgorithmTypeInvalid = -11003,
    TIEInitStatusCodeMLModelInitFailed = -11004,
    TIEInitStatusCodeInputResolutionInvalid = -11005
};

/*!
 * @brief The TIEAlgorithmType enum represents the algorithm running mode to be used for image enhancement.
 *
 * TIEAlgorithmTypeProfessionalHighQuality -> The TIEAlgorithmTypeProfessionalHighQuality mode ensures high image quality while requiring higher device performance. This mode is suitable for scenarios with high image quality requirements and is recommended for use on mid-to-high-end smartphones.
 * 
 * TIEAlgorithmTypeProfessionalFast -> The TIEAlgorithmTypeProfessionalFast mode ensures faster processing speed while sacrificing some image quality. This mode is suitable for scenarios with high real-time requirements and is recommended for use on mid-range smartphones.
 */
typedef NS_ENUM(NSInteger, TIEAlgorithmType) {
    TIEAlgorithmTypeProfessionalHighQuality API_AVAILABLE(ios(16.0)),
    TIEAlgorithmTypeProfessionalFast API_AVAILABLE(ios(15.0)),
};

/*!
 * TIEPass is a class responsible for performing image enhance rendering on input images using the Metal framework.
 *
 * TIEPass is responsible for initializing the image enhance rendering process with the specified input image size. It also provides a render method that applies the image enhance process to the input image and returns the processed image as an MTLTexture object.
 *
 * <p><b>Note: </b></p>
 * 1. Only available on iOS 15.0 or newer.
 * 2. This class uses the Metal framework for performing image enhance rendering and requires a device that supports Metal.
 * 3. All methods of TSRPass must be called within the same thread.
 * 4. The render:commandBuffer: and renderWithPixelBuffer: method should not be called before the initWithDevice:inputWidth:inputHeight:algorithmType:initStatusCode: method, and it should not be called after the deInit method.
 *
 * <p><b>Usage: </b></p>
 * 1. Create a TIEPass instance using the initWithDevice:inputWidth:inputHeight:algorithmType:initStatusCode: method.
 * 2. Call the render:commandBuffer: method with the input image's MTLTexture and an MTLCommandBuffer to perform image enhance rendering.
 * 3. Obtain the processed image as an MTLTexture from the return value of the render:commandBuffer: method.
 * 4. deInit method should be called when the TIEPass object is no longer needed, to free up the memory and other resources.
 */
API_AVAILABLE(ios(15.0))
@interface TIEPass: NSObject

/*!
 * Init TIEPass object for image enhance.
 *
 * @param device The MTLDevice which you are using.
 * @param inputWidth The width of the input image. This value should be between 1 to 4096.
 * @param inputHeight The height of the input image. This value should be between 1 to 4096.
 * @param algorithmType The TIEAlgorithmType enum value representing the algorithm running mode to be used.
 * @param initStatusCode A pointer to a TIEInitStatusCode enum value that will store the result of the initialization process. If initialization is successful, the value will be TIEInitStatusCodeSuccess. If initialization fails, the value will indicate the specific error that occurred.
 */
- (instancetype)initWithTIEAlgorithmType:(TIEAlgorithmType)algorithmType device:(id<MTLDevice>)device inputWidth:(int32_t)inputWidth inputHeight:(int32_t)inputHeight initStatusCode:(TIEInitStatusCode*)initStatusCode;

/**
 * Reinitializes the TIEPass object for image enhancement. The input parameters specify the new dimensions of the input image to be enhanced.
 *
 * @param inputWidth  The new width of the input image to be enhanced. This value should be between [1, 4096].
 * @param inputHeight The new height of the input image to be enhanced. This value should be between [1, 4096].
 * @return TIEInitStatusCode enum value that will store the result of the reinitialization process. If reinitialization is successful, the value will be TIEInitStatusCodeSuccess. If reinitialization fails, the value will indicate the specific error that occurred.
 */
- (TIEInitStatusCode) reInit:(int32_t)inputWidth inputHeight: (int32_t)inputHeight;

/*!
 * Performs the image enhance rendering operation on the input image.
 * <br>
 * This method applies the image enhance rendering process to the input image, improving its quality. The processed image is rendered onto a MTLTexture within
 * the TIEPass object. And the return is the MTLTexture which has preformed image enhance rendering .
 * <br>
 *
 * @param texture The MTLTexture of the input image that needs to be processed for image enhance. The format of the texture is BGRA.
 * @param commandBuffer The MTLCommandBuffer which you are using.
 * @return The MTLTexture that will be performed image enhance rendering, which is stored inside the TIEPass
 * object.
 */
- (id<MTLTexture>)render:(id<MTLTexture>)texture commandBuffer:(id<MTLCommandBuffer>)commandBuffer;

/*!
 * Performs the image enhance rendering operation on the input pixel buffer.
 *
 * This method applies the image enhance rendering process to the input pixel buffer, improving its quality. The processed pixel buffer is created and returned as a new CVPixelBufferRef.
 *
 * @note The SDK internally handles the lifecycle of the returned CVPixelBufferRef, therefore, the caller absolutely should not attempt to manually release the returned CVPixelBufferRef.
 *
 * @param pixelBuffer The CVPixelBufferRef of the input image that needs to be processed for image enhance. The width and height of the pixel buffer must match the inputWidth and inputHeight set during initialization, and the pixel format must be BGRA.
 * @return The CVPixelBufferRef that has been performed image enhance rendering. The size of the output pixel buffer is (inputWidth, inputHeight).
 */
- (CVPixelBufferRef)renderWithPixelBuffer:(CVPixelBufferRef)pixelBuffer;

/**
 * Releases the resources.
 * <br>
 * This method should be called when the TIEPass object is no longer needed, to free up the memory and other resources.
 */
- (void)deInit;

@end

#endif /* TIEPass_h */
