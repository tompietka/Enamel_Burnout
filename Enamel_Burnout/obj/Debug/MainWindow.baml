   M S B A M L   `   `   `  ����T  PMahApps.Metro, Version=1.1.2.0, Culture=neutral, PublicKeyToken=f4fb5a3c4d1e5b4fV;clr-namespace:MahApps.Metro.Controls;assembly=MahApps.MetroMahApps.Metro.Controls  5   	    Enamel_Burnout   Enamel_Burnout.MainWindow   5      HControls;clr-namespace:MahApps.Metro.Controls;assembly=MahApps.Metro  5   	   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	     � Title$%  Enamel Burndown Simulation Soft��5   	   $	��355��61   $	��436��6>   .��5      �  J� RenderTransformOrigin$ 0.5,0.5&�6   z�5   
   V� 5      .~�5	      �� �� 5
      �� 5       �� Angle$ 0.006Q�6"   T� 5      5      .+�5   
   �� $
��Left=�6   $	��143��60   $��	10,47,0,0q�6=   $	��Top=�6P   $	��138��6h   .+�5      �� $��25��6   $��Temperatura wypalania��6    �� 5      $��25��6   $��Czas wypalania��6    �� 5      $��25��6   $��Wsp. rozszerzalnośći��6    �� 5      $��25��6   $��Wysokość Półki��6    $
��Left=�69   $	��Top=�6T   $	��138��6l   5      �� 5   
   $
��Left=�6   $	��138��60   $��
148,47,0,0q�6=   $	��Top=�6Q   $	��208��6i   $ 
-0.41,0.06&�6u   .+�5      �� -   5        $��Temperatura��5   !   $��25��6    � Minimum$	 780Q�65    � Maximum$	 860Q�6C    �� TickFrequency$ 1Q�6Q    �� IsSnapToTickEnabled . 6c   �� 5      -   5        $
��Czas��5   !   $��25��6   $ 20Q�6.   $ 40Q�6;   $ 1Q�6H    . 6Z   �� 5      -   5         ��Name$ WspRozszerzalnosci��5   !   $��25��6   $ 10Q�6>   $ 20Q�6K   $	 0.1Q�6X    . 6l   �� 5      -   5        $
 Taca��5   !   $��25��6   $ 1Q�60   $ 3Q�6<   $	 0.1Q�6H    . 6\   5      �� 5   
   $
��Left=�6   $	��100��60   $��
361,47,0,0q�6=   $	��Top=�6Q   $��39��6i   .+�5      �� -   5        $��TxtBoxTemperatura��5   (    �� 
IsReadOnly . $��23��6A   	 �� TextWrapping$
	 Wrap=�6M   ��6a   �� 
 �� ElementName$
 Temperatura�� �� Path$ Value� �� UpdateSourceTrigger$ PropertyChanged=��� 5      -   5         ��Name$ 
TxtBoxCzas��5   (    . $��23��6<   $
	 Wrap=�6H   ��6\   �� *Value+$

 Czas��$ PropertyChanged=��� 5      -   5        $ 	TxtWspRoz��5   (    . $��23��6;   $
	 Wrap=�6G   ��6[   �� *Value+$
 WspRozszerzalnosci��$ PropertyChanged=�6�   �� 5      -   5        $ TxtTaca��5   (    . $��44��69   $
	 Wrap=�6E   ��6Y   �� *Value+$

 Taca��$ PropertyChanged=�6�   5       �� 5!   
   $
��Left=�6   $	��100��60   $��
10,190,0,0q�6=   $	��Top=�6Q   $	��138��6i   .+�5"      �� $��Prędkość taśmociągu��6   5#      �� 5$   
   $
��Left=�6   $	��100��60   $��148,190,0,0q�6=   $	��Top=�6R   $��59��6j   .+�5%      �� -	   5        $��Result��5%      $��23��6$   $
	 Wrap=�60    . 6D   5&      �� 5'   
   $
��Left=�6   $	��100��60   $��300,190,0,0q�6=   $	��Top=�6R   $	��100��6j   .+�5(      �� -
   5        $��	Symulacja��5(      6)   5)      �� 5*   
   $
��Left=�6   $	��100��60   $��300,228,0,0q�6=   $	��Top=�6R   $	��100��6j   .+�5+      �� -   5        $��Wynik��5+      6%   5,      5.      5/      