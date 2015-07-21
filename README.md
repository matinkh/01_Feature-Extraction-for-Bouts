# 01_Feature-Extraction-for-Bouts
Feature extraction for Bouts

Reads _.csv_ files in the selected folder, and for each bout found in that file, some features are extracted and written in the output file.

Example: executel the 
**run.m;** script

Here is the list of features in the output file:
- pid: participant's ID
- length_sec: bout length in second
- activity_count_per_bout: Maximum of activity count/duration among all bouts of a participant.
- lle: Largest Lyapunov Exponent... (not on default)
- hr: Harmonic Ratio
- skewness: Skewness of the signal
- kurtosis: Kurtosis coefficient of the signal
- xy_xcorr: Cross correlation between axis1 and axis2
- xz_xcorr: Cross correlation between axis1 and axis3
- yz_xcorr: Cross correlation between axis2 and axis3
- entropy_rate: Regularity of signal
- signal_avg: Average amplitude of signal
- signal_std: Standard deviation of signal
- zero_cross_rate: Zero crossing rate (or mean crossing rate)
- signal_max: Max signal amplitude
- signal_min: Min signal amplitude (and > 0)
- xy_autocorr: Autocorrelation between axis1 and axis2
- xz_autocorr: Autocorrelation between axis1 and axis3
- yz_autocorr: Autocorrelation between axis2 and axis3
- peak_frequency: Frequency where max amplitude happens
- wavelet_energy: Energy contribution
- wavelet_entropy: Signal disorder
- spectral_flux: How fast power spectrum changes (not ont default)
- xy_specCorr: Cross correlation between axis1 and axis2 in frequency
domain
- xz_specCorr: Cross correlation between axis1 and axis3 in frequency
domain
- yz_specCorr: Cross correlation between axis2 and axis3 in frequency
domain
- spectral_mean: Average of signal in frequency domain
- spectral_std: Standard deviation of signal in frequency domain
