Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FC43A543E
	for <linux-rt-devel@lists.linux.dev>; Thu,  9 Apr 2026 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775740804; cv=none; b=YkIXQUMs/k8VvmawNRu6adUeYAAGHyLeP2S9VCFNuaN8FzQ1Lmfr3MeeNGmPEY01TD+awmtA4EXHW1yxaqUbEv1Nt8WBuaTi3UNVwPdM1St8p6YbByrBPwM01XheZGruqDSz4oP8iCq9OoxMfuJxMl/XZEXZaC5p9fzLISL9Jsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775740804; c=relaxed/simple;
	bh=K5f3eOgbEJnuep20c7QPzcSdfq3tHpa42+VJmCLaaK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lUZ8z//XL985eVdh8RAdzTh9wdAG2YPKyidAH5Rh64aRUavf1r0Ypph/RblMKpYfScK2EDinS7K4nnvh9Zm+vSYKRezSKzCRcUzdvn2blhVuzf3kqgyYSUprSYcynPEH83t4M7BaceaMrF6BjkLFWEjKiUyTIMPozhahC0tEnHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=ScArKCic; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="ScArKCic"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1775740797; x=1776345597; i=spasswolf@web.de;
	bh=6b2l+CZDNg2pxI1O9oh0F6gJWUNI4pMAKls5VQTm8KY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ScArKCic5CHbL9sAeNvRt8EhV4920HGgeCi1hxtOx2EKldPsj3LiooCCbU/USpTw
	 xF+dMgyivmzoa0UEMUfNkFBRZ7pL57dfNBj1n7AVKpx7JENKxteCFBlTx29gke7d6
	 hWRC2fiXVy6cPa9PCODqfZe9WwBK7ws8wfVTcZxHVaruavbQY/BppvIzPIs9giQp9
	 C37kxsF3R347Mu0tXPZfXZK25qiG0OivSPf+CCmMfLbzcL1bkIA18rDQ0UP4x3of2
	 XXg39BYgeYr05yTA38JuWz4nZe2pROVRL0EqweF8hkgspVi8ERhAY5GFEw2oUPSDf
	 cQySOVKakW9fIAbi2w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsaW1-1vLLJv3wOh-014cGq; Thu, 09
 Apr 2026 15:14:13 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: Rafal Ostrowski <rafal.ostrowski@amd.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	Dillon Varone <dillon.varone@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	amd-gfx@lists.freedesktop.org
Subject: kernel panic when resuming from hibernate in next-20260406 with PREEMPT_RT
Date: Thu,  9 Apr 2026 15:14:10 +0200
Message-ID: <20260409131411.10598-1-spasswolf@web.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YYzBKjPwlUxWETH4D6FNCZqwJnwAMbgoUlrR0b1nRZGsngVlVMm
 M098039BdeWRqVkP1JKo6ouYV/nt6tK5/W8pw76W4+5zO36y58snRydX8RrmXXa9JLi/s5A
 RyvbbatUf1/MfpVG7HV/yBtxT3rtgInIEqAmtam6KJl1dPL3mpadZKVpe2/cQ80RjUMKy6I
 JYfneMQV+Z3+L8mUb0E8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eNVrwvqj4Jc=;AlTRFwfbn7gs8g0ot6I2fuQOOtz
 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
 FS

I noticed that my debian stable (trixie) system running linux next-20260406
would sometimes hang when resuming from hibernate (I also had two similar e=
rrors
under different circumstances, one just after booting and one when starting=
 the
game stellaris, but hibernate seems to be the best way to provoke this erro=
r).=20
There are usually no error messages, but once I got this (incomplete) error=
 (via drm panic "kmsg"):

[ 51.556812][ C0]  gpio_amdpt gpio_generic
[ 51.556817][ C0] ---[ end trace 0000000000000000 ]--- (the start tag is no=
t present in the qr_code)
[ 52.616208][ C0] RIP: 0010:__get_vm_area_node+0x140/0x150
[ 52.616214][ C0] Code: 00 00 ff c5 39 c5 0f 4c e8 b8 1e 00 00 00 39 c5 0f =
4f e8 c4 e2 d1 f7 ea e9 3e ff ff ff 4c 89 e7 e8 35 48 01 00 45 31 e4 eb b0 =
<0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 0f 1f 40 d6 41 50
[ 52.616215][ C0] RSP: 0010:ffffae404dcc3818 EFLAGS: 00010206
[ 52.616217][ C0] RAX: 0000000000ff0000 RBX: 000000000000000c RCX: 00000000=
00000022
[ 52.616217][ C0] RDX: 0000000000ff0000 RSI: 0000000000000001 RDI: 00000000=
0000f720
[ 52.616218][ C0] RBP: 000000000000000c R08: ffffae4040000000 R09: ffffce40=
3fffffff
[ 52.616218][ C0] R10: ffffce403fffffff R11: 0000000000000006 R12: ffff9f28=
9d400000
[ 52.616219][ C0] R13: ffff9f289d6e9fd0 R14: 0000000000000dc0 R15: 00000000=
0000f720
[ 52.616220][ C0] FS:  00007f814cdc9b40(0000) GS:ffff9f383a215000(0000) knl=
GS:0000000000000000
[ 52.616220][ C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000000050033
[ 52.616221][ C0] CR2: 00007f8134000020 CR3: 0000000201867000 CR4: 00000000=
00f50ef0
[ 52.616221][ C0] PKRU: 55555554
[ 52.616222][ C0] Kernel panic - not syncing: Fatal exception in interrupt
[ 52.616302][ C0] Kenrel Offset: 0xc00000 from 0xffffffff81000000 (relocati=
on range: 0xffffffff80000000-0xffffffffbfffffff)

I also got a really nice huge qrcode (via drm panic "qr_code") which showed=
 a little more of the message, but not
the beginning of the trace:

[ 125.266334][ C17] RSP: 002b:00007ffc1fcae230 EFLAGS: 00000246 ORIG_RAX: 0=
000000000000010
[ 125.266335][ C17] RAX: ffffffffffffffda RBX: 000055845b640060 RCX: 00007f=
b699e8e91b
[ 125.266335][ C17] RDX: 00007ffc1fcae2d0 RSI: 00000000c05064a7 RDI: 000000=
000000000f
[ 125.266336][ C17] RBP: 00007ffc1fcae2d0 R08: 0000000000000060 R09: 000000=
0000000000
[ 125.266336][ C17] R10: 0000000000000003 R11: 0000000000000246 R12: 000000=
00c05064a7
[ 125.266336][ C17] R13: 000000000000000f R14: 00000000c05064a7 R15: 00007f=
fc1fcae2d0
[ 125.266337][ C17] &lt;/TASK&gt;
[ 125.266337][ C17] Modules linked in: ccm snd_usb_audio joydev snd_usbmidi=
_lib snd_ump snd_rawmidi snd_seq_dummy snd_hrtimer snd_seq snd_seq_device n=
ls_ascii nls_cp437 vfat fat mt7925e mt7925_common mt792x_lib mt76_connac_li=
b mt76 intel_rapl_msr snd_hda_codec_atihdmi mac80211 intel_rapl_common snd_=
hda_codec_hdmi iosf_mbi snd_hda_intel rapl snd_hda_codec wmi_bmof snd_hda_c=
ore spd5118 regmap_i2c snd_intel_dspcfg snd_hwdep snd_pcm libarc4 snd_timer=
 cfg80211 snd soundcore pcspkr rfkill ccp k10temp evdev nct6775 nct6775_cor=
e hwmon_vid configfs efi_pstore efivarfs autofs4 ext4 mbcache jbd2 hid_gene=
ric usbhid hid amdgpu drm_client_lib i2c_algo_bit drm_buddy drm_ttm_helper =
ttm drm_exec drm_suballoc_helper mfd_core drm_panel_backlight_quirks gpu_sc=
hed amdxcp drm_display_helper xhci_pci xhci_hcd drm_kms_helper ahci libahci=
 drm libata usbcore nvme scsi_mod igc nvme_core cec i2c_piix4 scsi_common v=
ideo usb_common nvme_keyring crc16 i2c_smbus nvme_auth wmi hkdf gpio_amdpt =
gpio_generic
[ 125.266351][ C17] ---[ end trace 0000000000000000 ]---
[ 126.356624][ C17] RIP: 0010:__get_vm_area_node+0x140/0x150
[ 126.356631][ C17] Code: 00 00 ff c5 39 c5 0f 4c e8 b8 1e 00 00 00 39 c5 0=
f 4f e8 c4 e2 d1 f7 ea e9 3e ff ff ff 4c 89 e7 e8 f5 49 01 00 45 31 e4 eb b=
0 &lt;0f&gt; 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 0f 1f 40 d6 41 50
[ 126.356633][ C17] RSP: 0018:ffffb50f075275f8 EFLAGS: 00010206
[ 126.356635][ C17] RAX: 0000000000ff0000 RBX: 000000000000000c RCX: 000000=
0000000022
[ 126.356636][ C17] RDX: 0000000000ff0000 RSI: 0000000000000001 RDI: 000000=
000000f720
[ 126.356637][ C17] RBP: 000000000000000c R08: ffffb50f00000000 R09: ffffd5=
0effffffff
[ 126.356637][ C17] R10: ffffd50effffffff R11: 0000000000000006 R12: ffff90=
90a6000000
[ 126.356638][ C17] R13: ffff9090a62e9fd0 R14: 000000000000f720 R15: 000000=
0000000dc0
[ 126.356639][ C17] FS: 00007fb699b0eb40(0000) GS:ffff90a00a848000(0000) kn=
lGS:0000000000000000
[ 126.356640][ C17] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 126.356640][ C17] CR2: 00007f617c3fa02f CR3: 00000001a0c4e000 CR4: 000000=
0000f50ef0
[ 126.356641][ C17] PKRU: 55555554
[ 126.356642][ C17] Kernel panic - not syncing: Fatal exception in interrupt
[ 126.356811][ C17] Kernel Offset: 0x30a00000 from 0xffffffff81000000 (relo=
cation range: 0xffffffff80000000-0xffffffffbfffffff)

Hardware used:
$ lspci
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Root Complex
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge IOM=
MU
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Dummy Host Bridge
00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridg=
e GPP Bridge
00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridg=
e GPP Bridge
00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Dummy Host Bridge
00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridg=
e GPP Bridge
00:03.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Dummy Host Bridge
00:04.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Dummy Host Bridge
00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Dummy Host Bridge
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridg=
e Internal GPP Bridge to Bus [C:A]
00:08.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridg=
e Internal GPP Bridge to Bus [C:A]
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev=
 71)
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev =
51)
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 0
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 1
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 2
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 3
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 4
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 5
00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 6
00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 7
01:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Upstr=
eam Port of PCI Express Switch (rev 25)
02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Downs=
tream Port of PCI Express Switch (rev 25)
03:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] N=
avi 44 [RX 9060 XT] (rev c0)
03:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Navi 48 HDMI/D=
P Audio Controller
04:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD=
 9100 PRO [PM9E1]
05:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Upstream Port (rev 01)
06:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Downstream Port (rev 01)
06:06.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Downstream Port (rev 01)
06:07.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Downstream Port (rev 01)
06:08.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Downstream Port (rev 01)
06:0c.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Downstream Port (rev 01)
06:0d.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Downstream Port (rev 01)
08:00.0 Ethernet controller: Intel Corporation Ethernet Controller I226-V (=
rev 06)
09:00.0 Network controller: MEDIATEK Corp. Device 7925
0b:00.0 USB controller: Advanced Micro Devices, Inc. [AMD] 800 Series Chips=
et USB 3.x XHCI Controller (rev 01)
0c:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] 600 Series Chip=
set SATA Controller (rev 01)
0d:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. =
[AMD] Raphael/Granite Ridge PCIe Dummy Function (rev c1)
0d:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 19=
h PSP/CCP
0d:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Raphael/Granite =
Ridge USB 3.1 xHCI
0d:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Raphael/Granite =
Ridge USB 3.1 xHCI
0e:00.0 USB controller: Advanced Micro Devices, Inc. [AMD] Raphael/Granite =
Ridge USB 2.0 xHCI

$ cat /proc/cpuinfo=20
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 26
model		: 68
model name	: AMD Ryzen 9 9950X 16-Core Processor
stepping	: 0
microcode	: 0xb404035
cpu MHz		: 624.194
cache size	: 1024 KB
physical id	: 0
siblings	: 32
core id		: 0
cpu cores	: 16
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 16
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtsc=
p lm constant_tsc rep_good amd_lbr_v2 nopl xtopology nonstop_tsc cpuid extd=
_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 =
movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_l=
egacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext p=
erfctr_core perfctr_nb bpext perfctr_llc mwaitx cpuid_fault cpb cat_l3 cdp_=
l3 hw_pstate ssbd mba perfmon_v2 ibrs ibpb stibp ibrs_enhanced vmmcall fsgs=
base tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a avx512f avx512dq=
 rdseed adx smap avx512ifma clflushopt clwb avx512cd sha_ni avx512bw avx512=
vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_m=
bm_local user_shstk avx_vnni avx512_bf16 clzero irperf xsaveerptr rdpru wbn=
oinvd cppc arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasi=
d decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif x2avic v_=
spec_ctrl vnmi avx512vbmi umip pku ospke avx512_vbmi2 gfni vaes vpclmulqdq =
avx512_vnni avx512_bitalg avx512_vpopcntdq rdpid bus_lock_detect movdiri mo=
vdir64b overflow_recov succor smca fsrm avx512_vp2intersect flush_l1d amd_l=
br_pmc_freeze
bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass srso spectr=
e_v2_user vmscape
bogomips	: 8599.99
TLB size	: 192 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 48 bits physical, 48 bits virtual
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]

As the error does not occur in v7.0-rc7 I bisected the issue, declaring a c=
ommit as GOOD
when it passes 18 hibernate/resumes cycles (the issue is not 100% reproduci=
ble)

All these kernel are compiled with PREEMPT_RT:
7.0.0-rc7			     18 hibernate/resume cycles withot crash, GOOD
7.0.0-rc7-next-20260406-master	     crash on 1st resume, BAD
7.0.0-rc7-bisect-06060-g00f03539e3d9 18 hibernate/resume cycles without cra=
sh, GOOD
7.0.0-rc7-bisect-09155-g9a6b64640388 crash on 1st resume, BAD
7.0.0-rc4-bisect-01504-g8e005ef09ba5 18 hibernate/resume cycles without cra=
sh, GOOD
7.0.0-rc7-bisect-08350-gb82dff8ab846 crash on 4th resume, BAD
7.0.0-rc7-bisect-06517-ga03c0f5a4d5f 18 hibernate/resume cycles without cra=
sh, GOOD
7.0.0-rc6-bisect-01673-gcdd65e8bb954 crash on 6th resume, BAD
7.0.0-rc4-bisect-00705-g02ade2557eba 18 hibernate/resume cycles without cra=
sh, GOOD
7.0.0-rc4-bisect-01453-g353f20082505 crash on 8th resume, BAD
7.0.0-rc4-bisect-01428-g4c3aeb11d504 18 hibernate/resume cycles without cra=
sh, GOOD
7.0.0-rc4-bisect-01440-g60c741a13fd1 18 hibernate/resume cycles without cra=
sh, GOOD
7.0.0-rc4-bisect-01446-g32c1c35b6d8b crash on 12th resume, BAD
7.0.0-rc4-bisect-01443-g02c3060ee303 18 hibernate/resume cycles without cra=
sh, GOOD
7.0.0-rc4-bisect-01445-g4bb2f0721ed8 crash on 1st resume, BAD
7.0.0-rc4-bisect-01444-g3539437f354b crash on 3rd resume, BAD

The result of the bisection points to=20
commit 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC - Par=
t 1")
as the first bad commit.

As the offending commit contains preemption related macros I tried commit
3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC - Part 1")
without PREEMPT_RT and got no error in 24 cycles:
7.0.0-rc4-nort-01444-g3539437f354b 24 hibernate/resume cycles without crash

Any Ideas?

Bert Karwatzki


