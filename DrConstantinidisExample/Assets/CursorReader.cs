// this is the unity script for game object handling, and box/camera transforms

using System;
using System.IO;
using UnityEngine;

public class CursorReader : MonoBehaviour
{
    //replace filePath with your positions file location (generated from MATLAB script)
    private string filePath = "C:/GitHubRepos/VirtualISCAN-Serial-IO/LocalMatlabScripts/calculated_positions.txt";
    public Transform boxTransform;  //this is to assign the box in the Inspector
    public Camera mainCamera;      //assign the main camera in the Inspector

    private Vector3 screenCenter = new Vector3(0, 0, 0); //center of the screen in world space
    public float centerThreshold = 2;               //distance threshold for "in the middle"

    void Start()
    {
        //set the screen center to the actual middle of the screen (unity world coordinates)
        screenCenter = new Vector3(0, 0, 0);
    }

    void Update()
    {
        try
        {
            //this reads cursor data from our file
            if (File.Exists(filePath))
            {
                using (FileStream stream = new FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
                {
                    using (StreamReader reader = new StreamReader(stream))
                    {
                        string data = reader.ReadToEnd().Trim();

                        if (!string.IsNullOrEmpty(data))
                        {
                            //parsing the file
                            string[] parts = data.Split(',');
                            if (parts.Length == 2 &&
                                float.TryParse(parts[0], out float x) &&
                                float.TryParse(parts[1], out float y))
                            {

                                Debug.Log($"Virtual Eye Position: X={x}, Y={y}");

                                //this is responsible for moving the box based on cursor position
                                Vector3 newPosition = new Vector3(x / 100f, -y / 100f, 0);
                                boxTransform.position = Vector3.Lerp(boxTransform.position, newPosition, Time.deltaTime * 10f);

                                //check if the box is near the center
                                if (Vector3.Distance(boxTransform.position, screenCenter) <= centerThreshold)
                                {
                                    //change the scene color to green
                                    mainCamera.backgroundColor = Color.green;
                                    
                                }
                                else
                                {
                                    //reset to black
                                    mainCamera.backgroundColor = Color.black;
                                }
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Debug.LogError("Error reading file: " + ex.Message);
        }
    }
}
