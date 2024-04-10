import cv2
import numpy as np
import math

def shearX(image): 

    height=image.shape[0]
    width=image.shape[1]  

    # defining shearing angle
    angle=math.radians(20) 

    # intializing shearing matrix 
    shearingMatrix = np.array([[1, np.tan(angle), 0],[0, 1, 0],[0, 0, 1]])

    # defining blank image to output the sheared image on 
    output=np.zeros((int(height),int(1.2*width),3))

    for i in range(height):
        for j in range(width):

            # defining a matrix containing old co-ordinates
            xy = np.array([[j],[i],[1]])
            
            # using dot product to calculate the new co-ordinates for the sheared image
            shear_mat = np.dot(shearingMatrix,xy)
            new_y=int(shear_mat[1])
            new_x=int(shear_mat[0])

            # checking to prevent any errors in the processing
            if (0<=new_x<3*height) and (0<=new_y<width) : 
                output[new_y,new_x,:]=image[i,j,:]   
            
    return np.uint8(output)

def shearY(image):

    height=image.shape[0]
    width=image.shape[1]  
    
    # defining shearing angle
    angle = math.radians(20)

    # intializing shearing matrix 
    shearingMatrix = np.array([[1, 0, 0],[-np.tan(angle), 1, 0],[0, 0, 1]])

    # defining blank image to output the sheared image on 
    output=np.zeros((int(1.7*height),int(width),3))

    for i in range(height):
        for j in range(width):
            
            # defining a matrix containing old co-ordinates
            xy = np.array([[j],[i],[1]])

            # using dot product to calculate the new co-ordinates for the sheared image
            shear_mat = np.dot(shearingMatrix,xy)

            # adjusting the new co-ordinates since the y component is shifted 
            new_y=int(shear_mat[1]) + int(0.7*height)
            new_x=int(shear_mat[0]) 

            # checking to prevent any errors in the processing
            if (0<=new_x<3*height) and (0<=new_y<width) : 
                output[new_y,new_x,:]=image[i,j,:]   

    return np.uint8(output)


def rotate(image):      
    height=image.shape[0]
    width=image.shape[1]                     
    
    # intializing rotation matrix to rotate image 90 degrees clockwise
    rotation_mat = np.array([[0,-1],[1,0]])

    # defining blank image to output the rotated image on 
    output=np.zeros((width,height,3))

    center_height = round(((height+1)/2)-1)
    center_width = round(((width+1)/2)-1)

    for i in range(height):
        for j in range(width):

            # defining a matrix containing co-ordinates of pixels with respect to original image
            xy = np.array([[width-1-j-center_width],[height-1-i-center_height]])

            # using dot product to calculate the new co-ordinates for the rotated image
            rotate_mat = np.dot(rotation_mat,xy)

            new_y=center_width-int(rotate_mat[1])
            new_x=center_height-int(rotate_mat[0])

            if (0<=new_x<height) and (0<=new_y<width) : 
                output[new_y,new_x,:]=image[i,j,:]   
    return np.uint8(output)

def flip(image):
    height=image.shape[0]
    width=image.shape[1]  

   # defining blank image to output the flipped image on 
    output=np.zeros((height,width,3))

    for i in range(height):
        for j in range(width):

            # flipping pixels of the image line by line 
            output[i,width-j-1,:]=image[i,j,:]   
    
    return np.uint8(output)

def scale(image,scale_factor) :

    height=image.shape[0]
    width=image.shape[1] 

    # Compute the new dimensions of the scaled image
    new_width = round(width * scale_factor)
    new_height = round(height * scale_factor)

    # define a blank image to output the rotated image on
    output = np.zeros((new_height, new_width, 3))

    # Sample the original image and resize the subset to the desired size
    for i in range(new_height):
        for j in range(new_width):
            new_x = round(i / scale_factor)
            new_y = round(j / scale_factor)
            if (0<=new_x<height) and (0<=new_y<width) : 
                output[i,j,:]=image[new_x,new_y,:]       
    return np.uint8(output)

path = 'download.png'
img = cv2.imread(path)
showed_Image = img.copy()
scale_factor = 1 
while True :
    key = cv2.waitKey(1)

    print(scale_factor)
    # rotate image   
    if key ==ord('F') or key ==ord('f'):
        showed_Image = rotate(showed_Image)

    # reflect image  
    if key ==ord('e') or key ==ord('E'):
        showed_Image = flip(showed_Image)

    # Show original image  
    if key ==ord('s') or key ==ord('S'):
        showed_Image = img.copy()
        scale_factor = 1 

    # Scale image 
    if key ==ord('H') or key ==ord('h'):
        if scale_factor < 4 :
            showed_Image = img.copy()
            scale_factor += 0.2
            showed_Image = scale(showed_Image,scale_factor)
    if key ==ord('L') or key ==ord('l'):
        if scale_factor > 0.6 :
            showed_Image = img.copy()
            scale_factor -= 0.2
            showed_Image = scale(showed_Image,scale_factor)

    # shear the image in x-axis Direction
    if key ==ord('K') or key ==ord('k'):
        showed_Image = shearX(showed_Image)

    # shear the image in y-axis Direction
    if key ==ord('Y') or key ==ord('y'):
        showed_Image = shearY(showed_Image)

    # break the loop
    if key ==ord('q') or key ==ord('Q'):
        break
    cv2.imshow("Output",showed_Image)    


