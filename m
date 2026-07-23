Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950AE1DFDA1
	for <linux-rt-devel@lists.linux.dev>; Thu, 23 Jul 2026 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784810108; cv=none; b=G3JG22dyAB+6kTwJ8wl3SNETH7c0H6ESZvmix5MbhXmHopYSh8Ay9b0hYsvmRPyxRglY24PA3wMtonsU9J450afUMP8Tiucm/9tQUmO+pEIRmm89xRUQuIuGWAeXXixYuDR234H5MgZnf/HD4Ysh0BpBeofHO4rPEce+o/m7LAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784810108; c=relaxed/simple;
	bh=KtmuXUJvj56QSCHnpX8LH7cut+yPY19QeDI6LLZFgEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KrTMOi6/aD5GG1N25BFHoI6gbHD53g4bomaM7mLaJOD9H+PiU+LX6NQxd2iR5U32yJ5JLCgDnbX1Lnlx3kaXIK2kR/RSUiydxoOHHEzZZ7dlpnN+S+FLgoigDyzOzX3yGQVY63NsBdhBkyE+52HxUcSMJ0jx6hRNn4rGq1Dtky8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=GAbr5sXz; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="GAbr5sXz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784810091; x=1785414891; i=spasswolf@web.de;
	bh=EN7LFjbrarA2Zx1ELswnBw7byrrfs9PEX+abaEhRh/Q=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GAbr5sXzkh0VPQbxy3oR0ELZ26/ncAJAtm//vVU6tEDruuIefgGh4mBJoPcVL9BP
	 u7zKqm1mPqREHl/5yGMQDoNwFcHqs4MLRSrEZnhw3mCoM+7haKVNO6hi3V4T/qmYT
	 VqQCIsPJgBFM7Na09me9fHGGc0pyZzVWamHB38iZDgtH4qXHws1bWBxFnS+22bg8V
	 BLTg7MhwKrWwoc2Y3eEZLV7hyYnvr/K9bfjp+XAiJH8XfpvDHJSW9ZMswUFW9toBO
	 pSsvP0GMDgBZzkGhz6EGG3qTDucsdSzMleO9XqZE2AADCvPBcn1cYM9UtHiqkNfsX
	 g5633VTiKDXV5hv5VA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHmq2-1wj5HJ0gIo-002hCv; Thu, 23
 Jul 2026 14:34:51 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org,
	Rafal Ostrowski <rafal.ostrowski@amd.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-next@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: kernel panic during shutdown in v7.2-rc4 and next-20260722 with PREEMPT_RT
Date: Thu, 23 Jul 2026 14:34:48 +0200
Message-ID: <20260723123449.6494-1-spasswolf@web.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3ZpLTijiT1+HXlb7j1D13gdnZ3msFoWe6/b24IJjnm4+2cQvwK/
 sFDO0jOt7x64V4WIAWI2B8U9kpvvV12e0n4ZAVrQQ98kVHRken1PZQzcdsYn1tLU4Aj46pF
 GADRwQVELWgHXhuiQ4Z1ycSKFSJGsBocEMVBo9FEPz9fNMynM+EckMm55YNSiAztbjxpvib
 jmIIOeB0mwDlVSESXrOjA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TBc9zathqY4=;2eEYp2qoaB5lvq0QFMeOToeUnJe
 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
 8Q0W7K461BibD7zlzVQJz

When shutting down my Linux system (debian sid with kernel next-20260722 wi=
th PREEMPT_RT)
I either get an indefinite hang (with cursor blinking in the top left corner
of the screen) or a kernel panic qrcode with message "fatal exception in
interrupt". Unfortunately the qrcode cannot store the whole kernel message,
so I tried to bisect this (from v7.2-rc4 to next-20260722).
=20
During the bisection I also had kernel panics occuring when shutting down v=
7.2-rc4,
but these are much harder to reproduce.
I'll try to figure out what's going using git bisect but this may take some=
 time as I
a) Have to search for a good case
b) Go throught 10-20 reboot cycles to declare a commit as good

I used netconsole to capture an error message from next-20260722=20
T1473;BUG: scheduling while atomic: Xorg/1473/0x00000003
T1473,ncfrag=3D0/961;Modules linked in: netconsole snd_seq_dummy snd_hrtime=
r snd_seq nls_ascii nls_cp437 vfat fat joydev snd_usb_audio mt7925e snd_usb=
midi_lib snd_ump mt7925_common snd_rawmidi mt792x_lib snd_seq_device mt76_c=
onnac_lib intel_rapl_msr iosf_mbi mt76 snd_hda_codec_atihdmi intel_rapl_com=
mon snd_hda_codec_hdmi rapl mac80211 snd_hda_intel snd_hda_codec spd5118 re=
gmap_i2c snd_hda_core pcspkr snd_intel_dspcfg snd_hwdep snd_pcm snd_timer l=
ibarc4 snd cfg80211 soundcore k10temp rfkill evdev ccp nct6775 nct6775_core=
 hwmon_vid configfs efi_pstore efivarfs autofs4 ext4 mbcache jbd2 amdgpu hi=
d_generic usbhid hid drm_client_lib i2c_algo_bit drm_buddy drm_ttm_helper t=
tm drm_exec drm_suballoc_helper mfd_core drm_panel_backlight_quirks gpu_sch=
ed amdxcp drm_display_helper ahci libahci libata drm_kms_helper xhci_pci dr=
m xhci_hcd scsi_mod igc nvme usbcore cec nvme_core scsi_common crc16 video =
nvme_keyring nvme_au
T1473,ncfrag=3D899/961;th usb_common i2c_piix4 gpio_amdpt wmi gpio_generic =
i2c_smbus
T1473;CPU: 17 UID: 0 PID: 1473 Comm: Xorg Not tainted 7.2.0-rc4-next-202607=
22-gpuresetfix-00002-ga578edd2a4b3 #601 PREEMPT_RT=20
T1473;Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI,=
 BIOS 1627 02/05/2026
T1473;Call Trace:
T1473; <TASK>
T1473; ? dump_stack_lvl+0x4b/0x70
T1473; ? __schedule_bug.cold+0x3e/0x4a
T1473; ? __schedule+0xf5f/0x16e0
T1473; ? dml2_core_calcs_mode_programming_ex+0x2f60/0x6c80 [amdgpu]
T1473; ? schedule_rtlock+0x15/0x30
T1473; ? rtlock_slowlock_locked+0x30c/0xe50
T1473; ? rt_spin_lock+0xc3/0x120
T1473; ? get_page_from_freelist+0x248/0x19f0
T1473; ? __alloc_frozen_pages_noprof+0x197/0x330
T1473; ? ___kmalloc_large_node+0xb1/0xd0
T1473; ? __kvmalloc_node_noprof+0x383/0x560
T1473; ? dc_create_plane_state+0x24/0x90 [amdgpu]
T1473; ? dc_create_plane_state+0x24/0x90 [amdgpu]
T1473; ? dc_state_create_phantom_plane+0x15/0x50 [amdgpu]
T1473; ? dml21_handle_phantom_streams_planes+0x292/0x510 [amdgpu]
T1473; ? dml21_mode_check_and_programming+0x157/0x7d0 [amdgpu]
T1473; ? spl_set_filters_data+0xbc/0xd0 [amdgpu]
T1473; ? dcn401_validate_bandwidth+0xb8/0x1f0 [amdgpu]
T1473; ? update_planes_and_stream_state+0xffa/0x1630 [amdgpu]
T1473; ? update_planes_and_stream_prepare_v3+0xb6/0x440 [amdgpu]
T1473; ? dc_update_planes_and_stream+0x87/0x140 [amdgpu]
T1473; ? amdgpu_dm_atomic_commit_tail+0x1740/0x3750 [amdgpu]
T1473; ? commit_tail+0xcd/0x160 [drm_kms_helper]
T1473; ? drm_atomic_helper_commit+0x137/0x180 [drm_kms_helper]
T1473; ? drm_atomic_commit+0xac/0xe0 [drm]
T1473; ? __drm_universal_plane_init.cold+0x19/0x19 [drm]
T1473; ? drm_atomic_helper_set_config+0x6f/0xb0 [drm_kms_helper]
T1473; ? drm_mode_setcrtc+0x443/0x8b0 [drm]
T1473; ? drm_syncobj_transfer_ioctl+0x300/0x300 [drm]
T1473; ? rt_spin_trylock+0x1c/0x80
T1473; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1473; ? drm_ioctl_kernel+0xa1/0xf0 [drm]
T1473; ? drm_ioctl+0x27f/0x520 [drm]
T1473; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1473; ? amdgpu_drm_ioctl+0x45/0x80 [amdgpu]
T1473; ? __x64_sys_ioctl+0x92/0xe0
T1473; ? do_syscall_64+0xbd/0x500
T1473; ? __futex_wake_mark+0x50/0x50
T1473; ? futex_wait+0x66/0x110
T1473; ? wake_up_q+0x32/0x80
T1473; ? futex_wake+0x101/0x220
T1473; ? do_futex+0xd6/0x210
T1473; ? __x64_sys_futex+0x10d/0x200
T1473; ? do_futex+0x107/0x210
T1473; ? __x64_sys_futex+0x10d/0x200
T1473; ? do_syscall_64+0x1fa/0x500
T1473; ? __task_pid_nr_ns+0x53/0xe0
T1473; ? do_syscall_64+0xbd/0x500
T1473; ? do_syscall_64+0x37/0x500
T1473; ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
T1473; </TASK>
C17;------------[ cut here ]------------
T1473;WARNING: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:97 =
at dc_fpu_begin+0x4f/0x60 [amdgpu], CPU#17: Xorg/1473
T1473,ncfrag=3D0/961;Modules linked in: netconsole snd_seq_dummy snd_hrtime=
r snd_seq nls_ascii nls_cp437 vfat fat joydev snd_usb_audio mt7925e snd_usb=
midi_lib snd_ump mt7925_common snd_rawmidi mt792x_lib snd_seq_device mt76_c=
onnac_lib intel_rapl_msr iosf_mbi mt76 snd_hda_codec_atihdmi intel_rapl_com=
mon snd_hda_codec_hdmi rapl mac80211 snd_hda_intel snd_hda_codec spd5118 re=
gmap_i2c snd_hda_core pcspkr snd_intel_dspcfg snd_hwdep snd_pcm snd_timer l=
ibarc4 snd cfg80211 soundcore k10temp rfkill evdev ccp nct6775 nct6775_core=
 hwmon_vid configfs efi_pstore efivarfs autofs4 ext4 mbcache jbd2 amdgpu hi=
d_generic usbhid hid drm_client_lib i2c_algo_bit drm_buddy drm_ttm_helper t=
tm drm_exec drm_suballoc_helper mfd_core drm_panel_backlight_quirks gpu_sch=
ed amdxcp drm_display_helper ahci libahci libata drm_kms_helper xhci_pci dr=
m xhci_hcd scsi_mod igc nvme usbcore cec nvme_core scsi_common crc16 video =
nvme_keyring nvme_au
T1473,ncfrag=3D899/961;th usb_common i2c_piix4 gpio_amdpt wmi gpio_generic =
i2c_smbus
T1473;CPU: 17 UID: 0 PID: 1473 Comm: Xorg Tainted: G        W           7.2=
.0-rc4-next-20260722-gpuresetfix-00002-ga578edd2a4b3 #601 PREEMPT_RT=20
T1473;Tainted: [W]=3DWARN
T1473;Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI,=
 BIOS 1627 02/05/2026
T1473;RIP: 0010:dc_fpu_begin+0x4f/0x60 [amdgpu]
T1473;Code: d0 75 27 65 ff 05 a1 e8 db ce b8 01 00 00 00 65 0f c1 05 64 f8 =
dc ce 85 c0 74 05 c3 cc cc cc cc bf 02 00 00 00 e9 11 6d b8 cd <0f> 0b eb d=
5 66 90 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 d6 b8
T1473;RSP: 0018:ffffb251c623f5d0 EFLAGS: 00010206
T1473;RAX: 0000000000ff0000 RBX: ffff8a8f21400000 RCX: ffff8a8ed0f00000
T1473;RDX: 0000000000ff0000 RSI: 000000000000073d RDI: ffffffffc11b1540
T1473;RBP: 0000000000000001 R08: ffffb251c623f5a4 R09: 000000000000000a
T1473;R10: ffffb251c623f548 R11: 0000000000000002 R12: ffff8a8fa4468000
T1473;R13: ffff8a8ed1888000 R14: ffff8a8f89380000 R15: ffff8a8f21400000
T1473;FS:  00007eff71d77b80(0000) GS:ffff8a9e6e1b0000(0000) knlGS:000000000=
0000000
T1473;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
T1473;CR2: 00007ffcab257cc8 CR3: 0000000162691000 CR4: 0000000000f50ef0
T1473;PKRU: 55555554
T1473;Call Trace:
T1473; <TASK>
T1473; ? dcn401_prepare_mcache_programming+0x2f/0x70 [amdgpu]
T1473; ? commit_planes_for_stream+0x155/0x1900 [amdgpu]
T1473; ? update_planes_and_stream_execute_v3+0x3c/0xd0 [amdgpu]
T1473; ? dc_update_planes_and_stream+0xb6/0x140 [amdgpu]
T1473; ? amdgpu_dm_atomic_commit_tail+0x1740/0x3750 [amdgpu]
T1473; ? commit_tail+0xcd/0x160 [drm_kms_helper]
T1473; ? drm_atomic_helper_commit+0x137/0x180 [drm_kms_helper]
T1473; ? drm_atomic_commit+0xac/0xe0 [drm]
T1473; ? __drm_universal_plane_init.cold+0x19/0x19 [drm]
T1473; ? drm_atomic_helper_set_config+0x6f/0xb0 [drm_kms_helper]
T1473; ? drm_mode_setcrtc+0x443/0x8b0 [drm]
T1473; ? drm_syncobj_transfer_ioctl+0x300/0x300 [drm]
T1473; ? rt_spin_trylock+0x1c/0x80
T1473; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1473; ? drm_ioctl_kernel+0xa1/0xf0 [drm]
T1473; ? drm_ioctl+0x27f/0x520 [drm]
T1473; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1473; ? amdgpu_drm_ioctl+0x45/0x80 [amdgpu]
T1473; ? __x64_sys_ioctl+0x92/0xe0
T1473; ? do_syscall_64+0xbd/0x500
T1473; ? __futex_wake_mark+0x50/0x50
T1473; ? futex_wait+0x66/0x110
T1473; ? wake_up_q+0x32/0x80
T1473; ? futex_wake+0x101/0x220
T1473; ? do_futex+0xd6/0x210
T1473; ? __x64_sys_futex+0x10d/0x200
T1473; ? do_futex+0x107/0x210
T1473; ? __x64_sys_futex+0x10d/0x200
T1473; ? do_syscall_64+0x1fa/0x500
T1473; ? __task_pid_nr_ns+0x53/0xe0
T1473; ? do_syscall_64+0xbd/0x500
T1473; ? do_syscall_64+0x37/0x500
T1473; ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
T1473; </TASK>
T1473;---[ end trace 0000000000000000 ]---
C17;BUG: scheduling while atomic: Xorg/1473/0x7fffffff
C17,ncfrag=3D0/961;Modules linked in: netconsole snd_seq_dummy snd_hrtimer =
snd_seq nls_ascii nls_cp437 vfat fat joydev snd_usb_audio mt7925e snd_usbmi=
di_lib snd_ump mt7925_common snd_rawmidi mt792x_lib snd_seq_device mt76_con=
nac_lib intel_rapl_msr iosf_mbi mt76 snd_hda_codec_atihdmi intel_rapl_commo=
n snd_hda_codec_hdmi rapl mac80211 snd_hda_intel snd_hda_codec spd5118 regm=
ap_i2c snd_hda_core pcspkr snd_intel_dspcfg snd_hwdep snd_pcm snd_timer lib=
arc4 snd cfg80211 soundcore k10temp rfkill evdev ccp nct6775 nct6775_core h=
wmon_vid configfs efi_pstore efivarfs autofs4 ext4 mbcache jbd2 amdgpu hid_=
generic usbhid hid drm_client_lib i2c_algo_bit drm_buddy drm_ttm_helper ttm=
 drm_exec drm_suballoc_helper mfd_core drm_panel_backlight_quirks gpu_sched=
 amdxcp drm_display_helper ahci libahci libata drm_kms_helper xhci_pci drm =
xhci_hcd scsi_mod igc nvme usbcore cec nvme_core scsi_common crc16 video nv=
me_keyring nvme_auth
C17,ncfrag=3D901/961; usb_common i2c_piix4 gpio_amdpt wmi gpio_generic i2c_=
smbus
C17;CPU: 17 UID: 0 PID: 1473 Comm: Xorg Tainted: G        W           7.2.0=
-rc4-next-20260722-gpuresetfix-00002-ga578edd2a4b3 #601 PREEMPT_RT=20
C17;Tainted: [W]=3DWARN
C17;Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI, B=
IOS 1627 02/05/2026
C17;Call Trace:
C17; <TASK>
C17; ? dump_stack_lvl+0x4b/0x70
C17; ? __schedule_bug.cold+0x3e/0x4a
C17; ? __schedule+0xf5f/0x16e0
C17; ? __hrtimer_rearm_deferred+0x4c/0xd0
C17; ? schedule+0x22/0xa0
C17; ? usleep_range_state+0xbb/0xf0
C17; ? hrtimer_hres_workfn+0x10/0x10
C17; ? dcn10_wait_for_pipe_update_if_needed+0x231/0x240 [amdgpu]
C17; ? commit_planes_for_stream+0x2f2/0x1900 [amdgpu]
C17; ? update_planes_and_stream_execute_v3+0x3c/0xd0 [amdgpu]
C17; ? dc_update_planes_and_stream+0xb6/0x140 [amdgpu]
C17; ? amdgpu_dm_atomic_commit_tail+0x1740/0x3750 [amdgpu]
C17; ? commit_tail+0xcd/0x160 [drm_kms_helper]
C17; ? drm_atomic_helper_commit+0x137/0x180 [drm_kms_helper]
C17; ? drm_atomic_commit+0xac/0xe0 [drm]
C17; ? __drm_universal_plane_init.cold+0x19/0x19 [drm]
C17; ? drm_atomic_helper_set_config+0x6f/0xb0 [drm_kms_helper]
C17; ? drm_mode_setcrtc+0x443/0x8b0 [drm]
C17; ? drm_syncobj_transfer_ioctl+0x300/0x300 [drm]
C17; ? rt_spin_trylock+0x1c/0x80
C17; ? drm_mode_getcrtc+0x180/0x180 [drm]
C17; ? drm_ioctl_kernel+0xa1/0xf0 [drm]
C17; ? drm_ioctl+0x27f/0x520 [drm]
C17; ? drm_mode_getcrtc+0x180/0x180 [drm]
C17; ? amdgpu_drm_ioctl+0x45/0x80 [amdgpu]
C17; ? __x64_sys_ioctl+0x92/0xe0
C17; ? do_syscall_64+0xbd/0x500
C17; ? __futex_wake_mark+0x50/0x50
C17; ? futex_wait+0x66/0x110
C17; ? wake_up_q+0x32/0x80
C17; ? futex_wake+0x101/0x220
C17; ? do_futex+0xd6/0x210
C17; ? __x64_sys_futex+0x10d/0x200
C17; ? do_futex+0x107/0x210
C17; ? __x64_sys_futex+0x10d/0x200
C17; ? do_syscall_64+0x1fa/0x500
C17; ? __task_pid_nr_ns+0x53/0xe0
C17; ? do_syscall_64+0xbd/0x500
C17; ? do_syscall_64+0x37/0x500
C17; ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
C17; </TASK>
T1473;BUG: scheduling while atomic: Xorg/1473/0x00000003
T1473,ncfrag=3D0/961;Modules linked in: netconsole snd_seq_dummy snd_hrtime=
r snd_seq nls_ascii nls_cp437 vfat fat joydev snd_usb_audio mt7925e snd_usb=
midi_lib snd_ump mt7925_common snd_rawmidi mt792x_lib snd_seq_device mt76_c=
onnac_lib intel_rapl_msr iosf_mbi mt76 snd_hda_codec_atihdmi intel_rapl_com=
mon snd_hda_codec_hdmi rapl mac80211 snd_hda_intel snd_hda_codec spd5118 re=
gmap_i2c snd_hda_core pcspkr snd_intel_dspcfg snd_hwdep snd_pcm snd_timer l=
ibarc4 snd cfg80211 soundcore k10temp rfkill evdev ccp nct6775 nct6775_core=
 hwmon_vid configfs efi_pstore efivarfs autofs4 ext4 mbcache jbd2 amdgpu hi=
d_generic usbhid hid drm_client_lib i2c_algo_bit drm_buddy drm_ttm_helper t=
tm drm_exec drm_suballoc_helper mfd_core drm_panel_backlight_quirks gpu_sch=
ed amdxcp drm_display_helper ahci libahci libata drm_kms_helper xhci_pci dr=
m xhci_hcd scsi_mod igc nvme usbcore cec nvme_core scsi_common crc16 video =
nvme_keyring nvme_au
T1473,ncfrag=3D899/961;th usb_common i2c_piix4 gpio_amdpt wmi gpio_generic =
i2c_smbus
T1473;CPU: 17 UID: 0 PID: 1473 Comm: Xorg Tainted: G        W           7.2=
.0-rc4-next-20260722-gpuresetfix-00002-ga578edd2a4b3 #601 PREEMPT_RT=20
T1473;Tainted: [W]=3DWARN
T1473;Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI,=
 BIOS 1627 02/05/2026
T1473;Call Trace:
T1473; <TASK>
T1473; ? dump_stack_lvl+0x4b/0x70
T1473; ? __schedule_bug.cold+0x3e/0x4a
T1473; ? __schedule+0xf5f/0x16e0
T1473; ? dml2_core_calcs_mode_programming_ex+0x2f60/0x6c80 [amdgpu]
T1473; ? schedule_rtlock+0x15/0x30
T1473; ? rtlock_slowlock_locked+0x30c/0xe50
T1473; ? rt_spin_lock+0xc3/0x120
T1473; ? get_page_from_freelist+0x248/0x19f0
T1473; ? update_cfs_rq_load_avg+0x1a/0x240
T1473; ? __alloc_frozen_pages_noprof+0x197/0x330
T1473; ? ___kmalloc_large_node+0xb1/0xd0
T1473; ? __kvmalloc_node_noprof+0x383/0x560
T1473; ? dc_create_plane_state+0x24/0x90 [amdgpu]
T1473; ? dc_create_plane_state+0x24/0x90 [amdgpu]
T1473; ? dc_state_create_phantom_plane+0x15/0x50 [amdgpu]
T1473; ? dml21_handle_phantom_streams_planes+0x292/0x510 [amdgpu]
T1473; ? dml21_mode_check_and_programming+0x157/0x7d0 [amdgpu]
T1473; ? ___task_rq_lock+0x2d/0xa0
T1473; ? update_rq_clock+0x70/0x110
T1473; ? rt_mutex_setprio+0x61/0x340
T1473; ? calculate_plane_rec_in_timing_active+0x142/0x1f0 [amdgpu]
T1473; ? spl_calculate_number_of_taps.constprop.0.isra.0+0x142/0xf00 [amdgp=
u]
T1473; ? spl_calculate_number_of_taps.constprop.0.isra.0+0xed4/0xf00 [amdgp=
u]
T1473; ? dcn401_validate_bandwidth+0xb8/0x1f0 [amdgpu]
T1473; ? dc_validate_with_context+0x5c5/0x6a0 [amdgpu]
T1473; ? dc_commit_streams+0x27c/0x4f0 [amdgpu]
T1473; ? amdgpu_dm_atomic_commit_tail+0x681/0x3750 [amdgpu]
T1473; ? generic_reg_get+0x1c/0x30 [amdgpu]
T1473; ? optc1_get_crtc_scanoutpos+0x5f/0xa0 [amdgpu]
T1473; ? dc_stream_get_scanoutpos+0x7a/0xc0 [amdgpu]
T1473; ? amdgpu_display_get_crtc_scanoutpos+0xa5/0x1c0 [amdgpu]
T1473; ? amdgpu_display_crtc_idx_to_irq_type+0x30/0x30 [amdgpu]
T1473; ? amdgpu_crtc_get_scanout_position+0x23/0x30 [amdgpu]
T1473; ? drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x180/0x3b0 [=
drm]
T1473; ? wait_for_completion_timeout+0x122/0x170
T1473; ? drm_crtc_get_last_vbltimestamp+0x50/0x80 [drm]
T1473; ? commit_tail+0xcd/0x160 [drm_kms_helper]
T1473; ? drm_atomic_helper_commit+0x137/0x180 [drm_kms_helper]
T1473; ? drm_atomic_commit+0xac/0xe0 [drm]
T1473; ? __drm_universal_plane_init.cold+0x19/0x19 [drm]
T1473; ? drm_mode_obj_set_property_ioctl+0x162/0x3b0 [drm]
T1473; ? drm_mode_obj_find_prop_id+0x50/0x50 [drm]
T1473; ? drm_ioctl_kernel+0xa1/0xf0 [drm]
T1473; ? drm_ioctl+0x27f/0x520 [drm]
T1473; ? drm_mode_obj_find_prop_id+0x50/0x50 [drm]
T1473; ? rt_spin_trylock+0x1c/0x80
T1473; ? kmem_cache_free+0x214/0x430
T1473; ? amdgpu_drm_ioctl+0x45/0x80 [amdgpu]
T1473; ? __x64_sys_ioctl+0x92/0xe0
T1473; ? do_syscall_64+0xbd/0x500
T1473; ? do_epoll_ctl+0xbb/0xe0
T1473; ? __x64_sys_epoll_ctl+0x5f/0xa0
T1473; ? do_syscall_64+0xbd/0x500
T1473; ? count_memcg_events+0x67/0x110
T1473; ? handle_mm_fault+0x1bb/0x2c0
T1473; ? do_user_addr_fault+0x1e3/0x5e0
T1473; ? __flush_smp_call_function_queue+0x16a/0x1f0
T1473; ? do_syscall_64+0x37/0x500
T1473; ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
T1473; </TASK>
C17;BUG: scheduling while atomic: Xorg/1473/0x7fffffff
C17,ncfrag=3D0/961;Modules linked in: netconsole snd_seq_dummy snd_hrtimer =
snd_seq nls_ascii nls_cp437 vfat fat joydev snd_usb_audio mt7925e snd_usbmi=
di_lib snd_ump mt7925_common snd_rawmidi mt792x_lib snd_seq_device mt76_con=
nac_lib intel_rapl_msr iosf_mbi mt76 snd_hda_codec_atihdmi intel_rapl_commo=
n snd_hda_codec_hdmi rapl mac80211 snd_hda_intel snd_hda_codec spd5118 regm=
ap_i2c snd_hda_core pcspkr snd_intel_dspcfg snd_hwdep snd_pcm snd_timer lib=
arc4 snd cfg80211 soundcore k10temp rfkill evdev ccp nct6775 nct6775_core h=
wmon_vid configfs efi_pstore efivarfs autofs4 ext4 mbcache jbd2 amdgpu hid_=
generic usbhid hid drm_client_lib i2c_algo_bit drm_buddy drm_ttm_helper ttm=
 drm_exec drm_suballoc_helper mfd_core drm_panel_backlight_quirks gpu_sched=
 amdxcp drm_display_helper ahci libahci libata drm_kms_helper xhci_pci drm =
xhci_hcd scsi_mod igc nvme usbcore cec nvme_core scsi_common crc16 video nv=
me_keyring nvme_auth
C17,ncfrag=3D901/961; usb_common i2c_piix4 gpio_amdpt wmi gpio_generic i2c_=
smbus
C17;CPU: 17 UID: 0 PID: 1473 Comm: Xorg Tainted: G        W           7.2.0=
-rc4-next-20260722-gpuresetfix-00002-ga578edd2a4b3 #601 PREEMPT_RT=20
C17;Tainted: [W]=3DWARN
C17;Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI, B=
IOS 1627 02/05/2026
C17;Call Trace:
C17; <TASK>
C17; ? dump_stack_lvl+0x4b/0x70
C17; ? __schedule_bug.cold+0x3e/0x4a
C17; ? __schedule+0xf5f/0x16e0
C17; ? schedule+0x22/0xa0
C17; ? usleep_range_state+0xbb/0xf0
C17; ? hrtimer_hres_workfn+0x10/0x10
C17; ? dcn10_wait_for_pipe_update_if_needed+0x231/0x240 [amdgpu]
C17; ? dc_commit_state_no_check+0x1b0/0xe00 [amdgpu]
C17; ? dc_commit_streams+0x2f4/0x4f0 [amdgpu]
C17; ? amdgpu_dm_atomic_commit_tail+0x681/0x3750 [amdgpu]
C17; ? generic_reg_get+0x1c/0x30 [amdgpu]
C17; ? optc1_get_crtc_scanoutpos+0x5f/0xa0 [amdgpu]
C17; ? dc_stream_get_scanoutpos+0x7a/0xc0 [amdgpu]
C17; ? amdgpu_display_get_crtc_scanoutpos+0xa5/0x1c0 [amdgpu]
C17; ? amdgpu_display_crtc_idx_to_irq_type+0x30/0x30 [amdgpu]
C17; ? amdgpu_crtc_get_scanout_position+0x23/0x30 [amdgpu]
C17; ? drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x180/0x3b0 [dr=
m]
C17; ? wait_for_completion_timeout+0x122/0x170
C17; ? drm_crtc_get_last_vbltimestamp+0x50/0x80 [drm]
C17; ? commit_tail+0xcd/0x160 [drm_kms_helper]
C17; ? drm_atomic_helper_commit+0x137/0x180 [drm_kms_helper]
C17; ? drm_atomic_commit+0xac/0xe0 [drm]
C17; ? __drm_universal_plane_init.cold+0x19/0x19 [drm]
C17; ? drm_mode_obj_set_property_ioctl+0x162/0x3b0 [drm]
C17; ? drm_mode_obj_find_prop_id+0x50/0x50 [drm]
C17; ? drm_ioctl_kernel+0xa1/0xf0 [drm]
C17; ? drm_ioctl+0x27f/0x520 [drm]
C17; ? drm_mode_obj_find_prop_id+0x50/0x50 [drm]
C17; ? rt_spin_trylock+0x1c/0x80
C17; ? kmem_cache_free+0x214/0x430
C17; ? amdgpu_drm_ioctl+0x45/0x80 [amdgpu]
C17; ? __x64_sys_ioctl+0x92/0xe0
C17; ? do_syscall_64+0xbd/0x500
C17; ? do_epoll_ctl+0xbb/0xe0
C17; ? __x64_sys_epoll_ctl+0x5f/0xa0
C17; ? do_syscall_64+0xbd/0x500
C17; ? count_memcg_events+0x67/0x110
C17; ? handle_mm_fault+0x1bb/0x2c0
C17; ? do_user_addr_fault+0x1e3/0x5e0
C17; ? __flush_smp_call_function_queue+0x16a/0x1f0
C17; ? do_syscall_64+0x37/0x500
C17; ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
C17; </TASK>
T1273;wlp9s0: deauthenticating from 54:67:51:3d:a2:d2 by local choice (Reas=
on: 3=3DDEAUTH_LEAVING)
T23080;EXT4-fs (nvme0n1p5): unmounting filesystem 15783f8d-d7dd-4c1a-a7f8-8=
4d944f03886.
T23079;EXT4-fs (nvme0n1p4): unmounting filesystem ab8e4bed-5cab-4ae8-875a-8=
a42e075b551.
T1;systemd-shutdown[1]: Syncing filesystems and block devices.
T1;systemd-shutdown[1]: Sending SIGTERM to remaining processes...
T752;systemd-journald[752]: Received SIGTERM from PID 1 (systemd-shutdow).
T1;systemd-shutdown[1]: Sending SIGKILL to remaining processes...
T1;systemd-shutdown[1]: Unmounting file systems.
T23096;(sd-umount)[23096]: Unmounting '/run/credentials/systemd-journald.se=
rvice'.
T23097;(sd-remount)[23097]: Remounting '/' read-only with options 'errors=
=3Dremount-ro'.
T23097;EXT4-fs (nvme0n1p2): re-mounted 3d5cdc5d-1902-40bf-9e16-ca819372d350=
 ro.
T1;systemd-shutdown[1]: All filesystems unmounted.
T1;systemd-shutdown[1]: Deactivating swaps.
T1;systemd-shutdown[1]: All swaps deactivated.
T1;systemd-shutdown[1]: Detaching loop devices.
T1;systemd-shutdown[1]: All loop devices detached.
T1;systemd-shutdown[1]: Stopping MD devices.
T1;systemd-shutdown[1]: All MD devices stopped.
T1;systemd-shutdown[1]: Detaching DM devices.
T1;systemd-shutdown[1]: All DM devices detached.
T1;systemd-shutdown[1]: All filesystems, swaps, loop devices, MD devices an=
d DM devices detached.
T1;systemd-shutdown[1]: Syncing filesystems and block devices.
T1;systemd-shutdown[1]: Rebooting.

This error message shows that this is an amdgpu problem and also probably
a PREEMPT_RT problem (due to the scheduling while atomic message).
@rafal.ostrowski: This looks vaguely similar to the bug I reported in april=
, so maybe
you have an idea what's going on:
https://lore.kernel.org/all/20260409131411.10598-1-spasswolf@web.de/


Hardware:
$ lspci -nn
00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Root Complex [1022:14d8]
00:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ri=
dge IOMMU [1022:14d9]
00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Dummy Host Bridge [1022:14da]
00:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Raphael/Grani=
te Ridge GPP Bridge [1022:14db]
00:01.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Raphael/Grani=
te Ridge GPP Bridge [1022:14db]
00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Dummy Host Bridge [1022:14da]
00:02.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Raphael/Grani=
te Ridge GPP Bridge [1022:14db]
00:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Dummy Host Bridge [1022:14da]
00:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Dummy Host Bridge [1022:14da]
00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Dummy Host Bridge [1022:14da]
00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Raphael/Grani=
te Ridge Internal GPP Bridge to Bus [C:A] [1022:14dd]
00:08.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Raphael/Grani=
te Ridge Internal GPP Bridge to Bus [C:A] [1022:14dd]
00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controll=
er [1022:790b] (rev 71)
00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridg=
e [1022:790e] (rev 51)
00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Data Fabric; Function 0 [1022:14e0]
00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Data Fabric; Function 1 [1022:14e1]
00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Data Fabric; Function 2 [1022:14e2]
00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Data Fabric; Function 3 [1022:14e3]
00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Data Fabric; Function 4 [1022:14e4]
00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Data Fabric; Function 5 [1022:14e5]
00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Data Fabric; Function 6 [1022:14e6]
00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Data Fabric; Function 7 [1022:14e7]
01:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 X=
L Upstream Port of PCI Express Switch [1002:1478] (rev 25)
02:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 X=
L Downstream Port of PCI Express Switch [1002:1479] (rev 25)
03:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD=
/ATI] Navi 44 [Radeon RX 9060 XT] [1002:7590] (rev c0)
03:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Navi 48=
 HDMI/DP Audio Controller [1002:ab40]
04:00.0 Non-Volatile memory controller [0108]: Samsung Electronics Co Ltd N=
VMe SSD 9100 PRO [PM9E1] [144d:a810]
05:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series Ch=
ipset PCIe Switch Upstream Port [1022:43f4] (rev 01)
06:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series Ch=
ipset PCIe Switch Downstream Port [1022:43f5] (rev 01)
06:06.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series Ch=
ipset PCIe Switch Downstream Port [1022:43f5] (rev 01)
06:07.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series Ch=
ipset PCIe Switch Downstream Port [1022:43f5] (rev 01)
06:08.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series Ch=
ipset PCIe Switch Downstream Port [1022:43f5] (rev 01)
06:0c.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series Ch=
ipset PCIe Switch Downstream Port [1022:43f5] (rev 01)
06:0d.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series Ch=
ipset PCIe Switch Downstream Port [1022:43f5] (rev 01)
08:00.0 Ethernet controller [0200]: Intel Corporation Ethernet Controller I=
226-V [8086:125c] (rev 06)
09:00.0 Network controller [0280]: MEDIATEK Corp. MT7925 802.11be 160MHz 2x=
2 PCIe Wireless Network Adapter [Filogic 360] [14c3:7925]
0b:00.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] 800 Serie=
s Chipset USB 3.x XHCI Controller [1022:43fc] (rev 01)
0c:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] 600 Seri=
es Chipset SATA Controller [1022:43f6] (rev 01)
0d:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. =
[AMD] Raphael/Granite Ridge PCIe Dummy Function [1022:14de] (rev c1)
0d:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Fa=
mily 19h PSP/CCP [1022:1649]
0d:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Raphael/G=
ranite Ridge USB 3.1 xHCI [1022:15b6]
0d:00.4 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Raphael/G=
ranite Ridge USB 3.1 xHCI [1022:15b7]
0e:00.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Raphael/G=
ranite Ridge USB 2.0 xHCI [1022:15b8]

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
bogomips	: 8599.98
TLB size	: 192 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 48 bits physical, 48 bits virtual
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]


Bert Karwatzki
