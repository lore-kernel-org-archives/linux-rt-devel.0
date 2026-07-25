Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9402B40A943
	for <linux-rt-devel@lists.linux.dev>; Sat, 25 Jul 2026 19:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785009513; cv=none; b=pwPmc0B7MGKTShYiCY11T9glxV2tPWEzgvDpLr4PmPrfbW0GadQo8q0EiCI/BMVdhSbEQMlm7cEgQ0BhqZEVGvrz/ViCs/vSQkytYHzwbg0Dk2G5V7xp6XBc199I/OiovI7e/aYz7sB1tg4GdXJFAyp80jwgL6c9sX1Ett8JY90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785009513; c=relaxed/simple;
	bh=EhOD1Q8y5vJwe9U6ynButDr+eMfDswLA/H4FuuWXy70=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ml1AqGQT21476hHJQTsrPc40BuT9CcyU2hJ8cDr59QUcaQa947psEw2DMLaMm65qICBL8YTZ3X1hdPWbhESAlmApLMTuyF5cp7KQRmLBCngUelpRUu+cPp3jxM/wdZvlqFWmLl2TaBNHqxyYArHA7FY9lAoPbrnC6O9G6UvuJW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=Fs8E+mku; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="Fs8E+mku"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785009483; x=1785614283; i=spasswolf@web.de;
	bh=ib3PN30djc2mlqSGRas5P52Nro5lLo8IxYQUr4TSGfs=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Fs8E+mkufTp54KJa0KX34UeHNsajvVSU0kAUQrp1FFlZGI2nVXusMdRbcys/WYmq
	 52MIpaMWzHgkQ0wk3eIZHWm/vgd/Cvp15wDtrofk9AKmbb/0pSY4KRGyz8ySZmulo
	 gcW7BEA0CCMKC9R92PQG0z287m1M3/+NTDWXTogq91E5zlGDcPLkUqLEBj205StQ5
	 84NSTtdJE8kgKjeauVARkZBbpE+tDLox3rTjex3yEWTmN2sgVrupJmKO7L8z2Vzjt
	 lILzM5avdgOJsFDjJt0jpbOIUuVY8+Q9FCMy3fuPD2DWuoI1HlhDfHdarGeFG8oKR
	 8kKDJeKOFlB241WbDQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYLig-1wSM9J0vdS-00YkYA; Sat, 25
 Jul 2026 21:58:03 +0200
Message-ID: <dc5f1cfb267b0fb522b8aaa236b71b23e236df4d.camel@web.de>
Subject: Re: [Re] kernel panic during shutdown in  next-20260722
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org, Rafal Ostrowski <rafal.ostrowski@amd.com>
Cc: linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Thomas Gleixner	 <tglx@linutronix.de>,
 spasswolf@web.de
Date: Sat, 25 Jul 2026 21:58:02 +0200
In-Reply-To: <3c1be47abfcc907e7c1f9696cb25a24c93415a28.camel@web.de>
References: <20260723131001.11565-1-spasswolf@web.de>
					 <d24a136539c5931984f4855ad6596ca7aee8ebe2.camel@web.de>
			 <1a0800888c2fcd42f1fcd661d8f6f50580ac2fd4.camel@web.de>
		 <4d7c2dd588cd77d1d112da473f2a262d22051d57.camel@web.de>
	 <3c1be47abfcc907e7c1f9696cb25a24c93415a28.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G1wM+6RInKhkkE2Au0FAqwF0ZdXiW/e6wahTKYyzLtpSPIEhb4a
 EnPVgi/Z+vCv/6/m28i3OYEDT/AUwMjc4HpbYg095zqhC+nC/EuUNnIoc8HAH6A8MOSIinp
 QJm7zXo0CrZEIb7Cq5a/YGcoghqmBicE6EQGgoTdjc3DfeJ2YqsDYOGXa3CAMx9J2AuUk9u
 iiUhrvyhsURY1pS5ditsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jXVtgQXIqnE=;4+q+K4Sf/dFhiIgL2LrXPtXaHUc
 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
 +2ClAaKBxCE9i6VBYAQQ9

Am Freitag, dem 24.07.2026 um 17:08 +0200 schrieb Bert Karwatzki:
>=20
>=20
> 2) The "scheduling while atomic" errors which occur in v7.2-rc4 and earl=
ier, once I figure out
> these I'll contiue here (v6.19 is free from these errors)
>=20
> Bert Karwatzki

To figure out the "scheduling while atomic" errors when rebooting from v7.=
1 I first retested

commit 8bf0cb97edb ("drm/amd/display: Move dml2_destroy to non-FPU compila=
tion unit")

which was supposed to fix "scheduling while atomic" errors introduced by t=
hese patches:

32c1c35b6d8b drm/amd/display: Move FPU Guards From DML To DC - Part 3
4bb2f0721ed8 drm/amd/display: Move FPU Guards From DML To DC - Part 2
3539437f354b drm/amd/display: Move FPU Guards From DML To DC - Part 1

https://lore.kernel.org/lkml/20260409131411.10598-1-spasswolf@web.de/

On the 8th reboot I got an "scheduling while atomic" error (no panic thoug=
h):

T4874;netconsole: network logging started
T4874;netconsole-setup: Test log message to verify netconsole configuratio=
n.
T1499;BUG: scheduling while atomic: Xorg/1499/0x00000003
T1499,ncfrag=3D0/979;Modules linked in: netconsole ccm snd_seq_dummy snd_h=
rtimer snd_seq nls_ascii nls_cp437 vfat fat joydev snd_usb_audio mt7925e i=
ntel_rapl_msr
mt7925_common snd_usbmidi_lib snd_ump mt792x_lib snd_hda_codec_atihdmi snd=
_rawmidi snd_hda_codec_hdmi snd_seq_device mt76_connac_lib intel_rapl_comm=
on mt76
iosf_mbi rapl snd_hda_intel mac80211 wmi_bmof snd_hda_codec snd_hda_core s=
nd_intel_dspcfg pcspkr snd_hwdep spd5118 regmap_i2c snd_pcm libarc4 snd_ti=
mer cfg80211
snd soundcore k10temp rfkill evdev ccp nct6775 nct6775_core hwmon_vid conf=
igfs efi_pstore efivarfs autofs4 ext4 mbcache jbd2 amdgpu hid_generic drm_=
client_lib
i2c_algo_bit usbhid drm_buddy drm_ttm_helper hid ttm drm_exec drm_suballoc=
_helper mfd_core drm_panel_backlight_quirks gpu_sched amdxcp drm_display_h=
elper ahci
libahci xhci_pci libata xhci_hcd drm_kms_helper drm usbcore scsi_mod nvme =
igc nvme_core cec scsi_common crc16 video usb_common nvme_keyring nvm
T1499,ncfrag=3D919/979;e_auth i2c_piix4 hkdf gpio_amdpt gpio_generic i2c_s=
mbus wmi
T1499;CPU: 18 UID: 0 PID: 1499 Comm: Xorg Not tainted 7.0.0-rc7-bisect-019=
08-g8bf0cb97edb6 #1259 PREEMPT_{RT,(full)}=20
T1499;Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI=
, BIOS 1627 02/05/2026
T1499;Call Trace:
T1499; <TASK>
T1499; ? dump_stack_lvl+0x4b/0x70
T1499; ? __schedule_bug.cold+0x3e/0x4a
T1499; ? __schedule+0xedf/0x15c0
T1499; ? schedule_rtlock+0x15/0x30
T1499; ? rtlock_slowlock_locked+0x30b/0xe50
T1499; ? rt_spin_lock+0xc3/0x120
T1499; ? get_page_from_freelist+0x243/0x1630
T1499; ? rt_spin_unlock+0x5a/0xa0
T1499; ? __alloc_frozen_pages_noprof+0x146/0x2b0
T1499; ? ___kmalloc_large_node+0xd7/0xf0
T1499; ? __kvmalloc_node_noprof+0x398/0x540
T1499; ? dcn401_build_pipe_pix_clk_params+0x10a/0x1f0 [amdgpu]
T1499; ? dc_create_plane_state+0x24/0x80 [amdgpu]
T1499; ? dc_state_create_phantom_plane+0x15/0x50 [amdgpu]
T1499; ? dml21_handle_phantom_streams_planes+0x292/0x510 [amdgpu]
T1499; ? dml21_mode_check_and_programming+0x157/0x7e0 [amdgpu]
T1499; ? spl_set_filters_data+0xbc/0xd0 [amdgpu]
T1499; ? dcn401_validate_bandwidth+0xb8/0x1f0 [amdgpu]
T1499; ? update_planes_and_stream_state+0xeb5/0x1520 [amdgpu]
T1499; ? update_planes_and_stream_prepare_v3+0xb3/0x430 [amdgpu]
T1499; ? amdgpu_device_wreg+0x1e/0xe0 [amdgpu]
T1499; ? amdgpu_device_wreg+0x1e/0xe0 [amdgpu]
T1499; ? dc_update_planes_and_stream+0x87/0x130 [amdgpu]
T1499; ? amdgpu_dm_atomic_commit_tail+0x1239/0x35e0 [amdgpu]
T1499; ? commit_tail+0xcd/0x160 [drm_kms_helper]
T1499; ? drm_atomic_helper_commit+0x137/0x180 [drm_kms_helper]
T1499; ? drm_atomic_commit+0xac/0xe0 [drm]
T1499; ? __drm_universal_plane_init.cold+0x12/0x12 [drm]
T1499; ? drm_atomic_helper_set_config+0x6f/0xb0 [drm_kms_helper]
T1499; ? drm_mode_setcrtc+0x443/0x8b0 [drm]
T1499; ? do_futex+0xc0/0x180
T1499; ? __x64_sys_futex+0x10d/0x200
T1499; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1499; ? drm_ioctl_kernel+0xa1/0xf0 [drm]
T1499; ? drm_ioctl+0x27f/0x520 [drm]
T1499; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1499; ? amdgpu_drm_ioctl+0x45/0x80 [amdgpu]
T1499; ? __x64_sys_ioctl+0x92/0xe0
T1499; ? do_syscall_64+0x118/0x5e0
T1499; ? irqentry_exit+0x325/0x560
T1499; ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
T1499; </TASK>
T1499;------------[ cut here ]------------
T1499;WARNING: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:12=
6 at dc_fpu_end+0x36/0x40 [amdgpu], CPU#17: Xorg/1499
T1499,ncfrag=3D0/979;Modules linked in: netconsole ccm snd_seq_dummy snd_h=
rtimer snd_seq nls_ascii nls_cp437 vfat fat joydev snd_usb_audio mt7925e i=
ntel_rapl_msr
mt7925_common snd_usbmidi_lib snd_ump mt792x_lib snd_hda_codec_atihdmi snd=
_rawmidi snd_hda_codec_hdmi snd_seq_device mt76_connac_lib intel_rapl_comm=
on mt76
iosf_mbi rapl snd_hda_intel mac80211 wmi_bmof snd_hda_codec snd_hda_core s=
nd_intel_dspcfg pcspkr snd_hwdep spd5118 regmap_i2c snd_pcm libarc4 snd_ti=
mer cfg80211
snd soundcore k10temp rfkill evdev ccp nct6775 nct6775_core hwmon_vid conf=
igfs efi_pstore efivarfs autofs4 ext4 mbcache jbd2 amdgpu hid_generic drm_=
client_lib
i2c_algo_bit usbhid drm_buddy drm_ttm_helper hid ttm drm_exec drm_suballoc=
_helper mfd_core drm_panel_backlight_quirks gpu_sched amdxcp drm_display_h=
elper ahci
libahci xhci_pci libata xhci_hcd drm_kms_helper drm usbcore scsi_mod nvme =
igc nvme_core cec scsi_common crc16 video usb_common nvme_keyring nvm
T1499,ncfrag=3D919/979;e_auth i2c_piix4 hkdf gpio_amdpt gpio_generic i2c_s=
mbus wmi
T1499;CPU: 17 UID: 0 PID: 1499 Comm: Xorg Tainted: G        W           7.=
0.0-rc7-bisect-01908-g8bf0cb97edb6 #1259 PREEMPT_{RT,(full)}=20
T1499;Tainted: [W]=3DWARN
T1499;Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI=
, BIOS 1627 02/05/2026
T1499;RIP: 0010:dc_fpu_end+0x36/0x40 [amdgpu]
T1499;Code: 05 7f f9 76 f1 ff c8 74 10 78 1f 65 ff 0d a2 e9 75 f1 74 0c c3=
 cc cc cc cc e8 86 f3 72 f0 eb eb e8 6f 63 71 f0 c3 cc cc cc cc <0f> 0b eb=
 dd 66 0f 1f
44 00 00 41 56 41 55 41 54 55 53 48 83 ec 10
T1499;RSP: 0018:ffffb02c0a13f670 EFLAGS: 00010296
T1499;RAX: 00000000ffffffff RBX: ffff973c82b80000 RCX: 0000000000000008
T1499;RDX: 0000000000000000 RSI: 00000000000006a4 RDI: ffffffffc1599830
T1499;RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000001
T1499;R10: ffff973c82b80000 R11: 0000000000000002 R12: ffff973c40290000
T1499;R13: ffff973be0c00000 R14: 0000000000000000 R15: 0000000000000001
T1499;FS:  00007f0caaec0b80(0000) GS:ffff974acb3b9000(0000) knlGS:00000000=
00000000
T1499;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
T1499;CR2: 00007fb6d8830990 CR3: 000000010a518000 CR4: 0000000000f50ef0
T1499;PKRU: 55555554
T1499;Call Trace:
T1499; <TASK>
T1499; ? dcn401_validate_bandwidth+0xd1/0x1f0 [amdgpu]
T1499; ? update_planes_and_stream_state+0xeb5/0x1520 [amdgpu]
T1499; ? update_planes_and_stream_prepare_v3+0xb3/0x430 [amdgpu]
T1499; ? amdgpu_device_wreg+0x1e/0xe0 [amdgpu]
T1499; ? amdgpu_device_wreg+0x1e/0xe0 [amdgpu]
T1499; ? dc_update_planes_and_stream+0x87/0x130 [amdgpu]
T1499; ? amdgpu_dm_atomic_commit_tail+0x1239/0x35e0 [amdgpu]
T1499; ? commit_tail+0xcd/0x160 [drm_kms_helper]
T1499; ? drm_atomic_helper_commit+0x137/0x180 [drm_kms_helper]
T1499; ? drm_atomic_commit+0xac/0xe0 [drm]
T1499; ? __drm_universal_plane_init.cold+0x12/0x12 [drm]
T1499; ? drm_atomic_helper_set_config+0x6f/0xb0 [drm_kms_helper]
T1499; ? drm_mode_setcrtc+0x443/0x8b0 [drm]
T1499; ? do_futex+0xc0/0x180
T1499; ? __x64_sys_futex+0x10d/0x200
T1499; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1499; ? drm_ioctl_kernel+0xa1/0xf0 [drm]
T1499; ? drm_ioctl+0x27f/0x520 [drm]
T1499; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1499; ? amdgpu_drm_ioctl+0x45/0x80 [amdgpu]
T1499; ? __x64_sys_ioctl+0x92/0xe0
T1499; ? do_syscall_64+0x118/0x5e0
T1499; ? irqentry_exit+0x325/0x560
T1499; ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
T1499; </TASK>
T1499;---[ end trace 0000000000000000 ]---
T1499;------------[ cut here ]------------
T1499;WARNING: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:97=
 at dc_fpu_begin+0x4f/0x60 [amdgpu], CPU#17: Xorg/1499
T1499,ncfrag=3D0/979;Modules linked in: netconsole ccm snd_seq_dummy snd_h=
rtimer snd_seq nls_ascii nls_cp437 vfat fat joydev snd_usb_audio mt7925e i=
ntel_rapl_msr
mt7925_common snd_usbmidi_lib snd_ump mt792x_lib snd_hda_codec_atihdmi snd=
_rawmidi snd_hda_codec_hdmi snd_seq_device mt76_connac_lib intel_rapl_comm=
on mt76
iosf_mbi rapl snd_hda_intel mac80211 wmi_bmof snd_hda_codec snd_hda_core s=
nd_intel_dspcfg pcspkr snd_hwdep spd5118 regmap_i2c snd_pcm libarc4 snd_ti=
mer cfg80211
snd soundcore k10temp rfkill evdev ccp nct6775 nct6775_core hwmon_vid conf=
igfs efi_pstore efivarfs autofs4 ext4 mbcache jbd2 amdgpu hid_generic drm_=
client_lib
i2c_algo_bit usbhid drm_buddy drm_ttm_helper hid ttm drm_exec drm_suballoc=
_helper mfd_core drm_panel_backlight_quirks gpu_sched amdxcp drm_display_h=
elper ahci
libahci xhci_pci libata xhci_hcd drm_kms_helper drm usbcore scsi_mod nvme =
igc nvme_core cec scsi_common crc16 video usb_common nvme_keyring nvm
T1499,ncfrag=3D919/979;e_auth i2c_piix4 hkdf gpio_amdpt gpio_generic i2c_s=
mbus wmi
T1499;CPU: 17 UID: 0 PID: 1499 Comm: Xorg Tainted: G        W           7.=
0.0-rc7-bisect-01908-g8bf0cb97edb6 #1259 PREEMPT_{RT,(full)}=20
T1499;Tainted: [W]=3DWARN
T1499;Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI=
, BIOS 1627 02/05/2026
T1499;RIP: 0010:dc_fpu_begin+0x4f/0x60 [amdgpu]
T1499;Code: d0 75 27 65 ff 05 f1 e9 75 f1 b8 01 00 00 00 65 0f c1 05 b4 f9=
 76 f1 85 c0 74 05 c3 cc cc cc cc bf 02 00 00 00 e9 41 f4 72 f0 <0f> 0b eb=
 d5 66 90 66
66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 d6 b8
T1499;RSP: 0018:ffffb02c0a13f7e8 EFLAGS: 00010206
T1499;RAX: 0000000000ff0000 RBX: ffff973be0c00000 RCX: 0000000000000000
T1499;RDX: 0000000000ff0000 RSI: 00000000000006c8 RDI: ffffffffc1599800
T1499;RBP: ffff973c82b80000 R08: ffffb02c0a13f7bc R09: 000000000000000a
T1499;R10: ffffb02c0a13f760 R11: 0000000000000002 R12: ffff973c40290000
T1499;R13: 0000000000000001 R14: ffff973be0c00000 R15: ffff973b4e999000
T1499;FS:  00007f0caaec0b80(0000) GS:ffff974acb3b9000(0000) knlGS:00000000=
00000000
T1499;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
T1499;CR2: 00007fb6d8830990 CR3: 000000010a518000 CR4: 0000000000f50ef0
T1499;PKRU: 55555554
T1499;Call Trace:
T1499; <TASK>
T1499; ? dcn401_prepare_mcache_programming+0x2f/0x70 [amdgpu]
T1499; ? commit_planes_for_stream+0x157/0x1870 [amdgpu]
T1499; ? update_planes_and_stream_execute_v3+0x3c/0xd0 [amdgpu]
T1499; ? dc_update_planes_and_stream+0xb6/0x130 [amdgpu]
T1499; ? amdgpu_dm_atomic_commit_tail+0x1239/0x35e0 [amdgpu]
T1499; ? commit_tail+0xcd/0x160 [drm_kms_helper]
T1499; ? drm_atomic_helper_commit+0x137/0x180 [drm_kms_helper]
T1499; ? drm_atomic_commit+0xac/0xe0 [drm]
T1499; ? __drm_universal_plane_init.cold+0x12/0x12 [drm]
T1499; ? drm_atomic_helper_set_config+0x6f/0xb0 [drm_kms_helper]
T1499; ? drm_mode_setcrtc+0x443/0x8b0 [drm]
T1499; ? do_futex+0xc0/0x180
T1499; ? __x64_sys_futex+0x10d/0x200
T1499; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1499; ? drm_ioctl_kernel+0xa1/0xf0 [drm]
T1499; ? drm_ioctl+0x27f/0x520 [drm]
T1499; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1499; ? amdgpu_drm_ioctl+0x45/0x80 [amdgpu]
T1499; ? __x64_sys_ioctl+0x92/0xe0
T1499; ? do_syscall_64+0x118/0x5e0
T1499; ? irqentry_exit+0x325/0x560
T1499; ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
T1499; </TASK>
T1499;---[ end trace 0000000000000000 ]---
T1499;BUG: scheduling while atomic: Xorg/1499/0x00000000
T1499,ncfrag=3D0/979;Modules linked in: netconsole ccm snd_seq_dummy snd_h=
rtimer snd_seq nls_ascii nls_cp437 vfat fat joydev snd_usb_audio mt7925e i=
ntel_rapl_msr
mt7925_common snd_usbmidi_lib snd_ump mt792x_lib snd_hda_codec_atihdmi snd=
_rawmidi snd_hda_codec_hdmi snd_seq_device mt76_connac_lib intel_rapl_comm=
on mt76
iosf_mbi rapl snd_hda_intel mac80211 wmi_bmof snd_hda_codec snd_hda_core s=
nd_intel_dspcfg pcspkr snd_hwdep spd5118 regmap_i2c snd_pcm libarc4 snd_ti=
mer cfg80211
snd soundcore k10temp rfkill evdev ccp nct6775 nct6775_core hwmon_vid conf=
igfs efi_pstore efivarfs autofs4 ext4 mbcache jbd2 amdgpu hid_generic drm_=
client_lib
i2c_algo_bit usbhid drm_buddy drm_ttm_helper hid ttm drm_exec drm_suballoc=
_helper mfd_core drm_panel_backlight_quirks gpu_sched amdxcp drm_display_h=
elper ahci
libahci xhci_pci libata xhci_hcd drm_kms_helper drm usbcore scsi_mod nvme =
igc nvme_core cec scsi_common crc16 video usb_common nvme_keyring nvm
T1499,ncfrag=3D919/979;e_auth i2c_piix4 hkdf gpio_amdpt gpio_generic i2c_s=
mbus wmi
T1499;CPU: 17 UID: 0 PID: 1499 Comm: Xorg Tainted: G        W           7.=
0.0-rc7-bisect-01908-g8bf0cb97edb6 #1259 PREEMPT_{RT,(full)}=20
T1499;Tainted: [W]=3DWARN
T1499;Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI=
, BIOS 1627 02/05/2026
T1499;Call Trace:
T1499; <TASK>
T1499; ? dump_stack_lvl+0x4b/0x70
T1499; ? __schedule_bug.cold+0x3e/0x4a
T1499; ? __schedule+0xedf/0x15c0
T1499; ? psi_task_change+0xbf/0xd0
T1499; ? lock_timer_base+0x6b/0x90
T1499; ? __mod_timer+0x116/0x330
T1499; ? schedule+0x22/0xd0
T1499; ? schedule_timeout+0x76/0xf0
T1499; ? hrtimers_cpu_dying+0x1a0/0x1a0
T1499; ? wait_for_completion_timeout+0x78/0x170
T1499; ? drm_atomic_helper_wait_for_flip_done+0x46/0x90 [drm_kms_helper]
T1499; ? amdgpu_dm_atomic_commit_tail+0x2c6d/0x35e0 [amdgpu]
T1499; ? commit_tail+0xcd/0x160 [drm_kms_helper]
T1499; ? drm_atomic_helper_commit+0x137/0x180 [drm_kms_helper]
T1499; ? drm_atomic_commit+0xac/0xe0 [drm]
T1499; ? __drm_universal_plane_init.cold+0x12/0x12 [drm]
T1499; ? drm_atomic_helper_set_config+0x6f/0xb0 [drm_kms_helper]
T1499; ? drm_mode_setcrtc+0x443/0x8b0 [drm]
T1499; ? do_futex+0xc0/0x180
T1499; ? __x64_sys_futex+0x10d/0x200
T1499; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1499; ? drm_ioctl_kernel+0xa1/0xf0 [drm]
T1499; ? drm_ioctl+0x27f/0x520 [drm]
T1499; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1499; ? amdgpu_drm_ioctl+0x45/0x80 [amdgpu]
T1499; ? __x64_sys_ioctl+0x92/0xe0
T1499; ? do_syscall_64+0x118/0x5e0
T1499; ? irqentry_exit+0x325/0x560
T1499; ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
T1499; </TASK>
T1499;------------[ cut here ]------------
T1499;WARNING: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:58=
 at dc_assert_fp_enabled+0x14/0x20 [amdgpu], CPU#17: Xorg/1499
T1499,ncfrag=3D0/979;Modules linked in: netconsole ccm snd_seq_dummy snd_h=
rtimer snd_seq nls_ascii nls_cp437 vfat fat joydev snd_usb_audio mt7925e i=
ntel_rapl_msr
mt7925_common snd_usbmidi_lib snd_ump mt792x_lib snd_hda_codec_atihdmi snd=
_rawmidi snd_hda_codec_hdmi snd_seq_device mt76_connac_lib intel_rapl_comm=
on mt76
iosf_mbi rapl snd_hda_intel mac80211 wmi_bmof snd_hda_codec snd_hda_core s=
nd_intel_dspcfg pcspkr snd_hwdep spd5118 regmap_i2c snd_pcm libarc4 snd_ti=
mer cfg80211
snd soundcore k10temp rfkill evdev ccp nct6775 nct6775_core hwmon_vid conf=
igfs efi_pstore efivarfs autofs4 ext4 mbcache jbd2 amdgpu hid_generic drm_=
client_lib
i2c_algo_bit usbhid drm_buddy drm_ttm_helper hid ttm drm_exec drm_suballoc=
_helper mfd_core drm_panel_backlight_quirks gpu_sched amdxcp drm_display_h=
elper ahci
libahci xhci_pci libata xhci_hcd drm_kms_helper drm usbcore scsi_mod nvme =
igc nvme_core cec scsi_common crc16 video usb_common nvme_keyring nvm
T1499,ncfrag=3D919/979;e_auth i2c_piix4 hkdf gpio_amdpt gpio_generic i2c_s=
mbus wmi
T1499;CPU: 17 UID: 0 PID: 1499 Comm: Xorg Tainted: G        W           7.=
0.0-rc7-bisect-01908-g8bf0cb97edb6 #1259 PREEMPT_{RT,(full)}=20
T1499;Tainted: [W]=3DWARN
T1499;Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI=
, BIOS 1627 02/05/2026
T1499;RIP: 0010:dc_assert_fp_enabled+0x14/0x20 [amdgpu]
T1499;Code: 00 5b e9 ff 33 79 f0 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00=
 00 0f 1f 40 d6 65 8b 05 25 fa 76 f1 85 c0 7e 05 c3 cc cc cc cc <0f> 0b c3=
 cc cc cc cc
0f 1f 44 00 00 0f 1f 40 d6 65 8b 05 05 fa 76
T1499;RSP: 0018:ffffb02c0a13f418 EFLAGS: 00010246
T1499;RAX: 0000000000000000 RBX: ffffb02c0a7c3128 RCX: 0000000000000000
T1499;RDX: 00000000000003d8 RSI: ffffffffc15b1c18 RDI: ffffb02c0a7c3cf0
T1499;RBP: ffff973be0c00000 R08: 0000000000000008 R09: ffffe3ef8492ebc0
T1499;R10: ffffe3ef8492ea00 R11: ffff974a7d86b408 R12: ffffb02c0a7c1008
T1499;R13: ffff973b83900010 R14: ffff973be0ee9fc8 R15: ffff973be0c00000
T1499;FS:  00007f0caaec0b80(0000) GS:ffff974acb3b9000(0000) knlGS:00000000=
00000000
T1499;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
T1499;CR2: 0000564066480de0 CR3: 000000010a518000 CR4: 0000000000f50ef0
T1499;PKRU: 55555554
T1499;Call Trace:
T1499; <TASK>
T1499; ? dcn401_get_soc_bb+0x3f/0x70 [amdgpu]
T1499; ? dml21_populate_dml_init_params+0x61/0x1d0 [amdgpu]
T1499; ? dml21_init+0x6a/0x90 [amdgpu]
T1499; ? dml21_create+0x34/0x50 [amdgpu]
T1499; ? dc_state_create+0xc8/0x140 [amdgpu]
T1499; ? create_validate_stream_for_sink+0xb7/0x510 [amdgpu]
T1499; ? dm_update_crtc_state+0x2d0/0x810 [amdgpu]
T1499; ? amdgpu_dm_atomic_check+0x98f/0x1840 [amdgpu]
T1499; ? drm_atomic_check_only+0x5d9/0xa00 [drm]
T1499; ? drm_atomic_commit+0x6c/0xe0 [drm]
T1499; ? __drm_universal_plane_init.cold+0x12/0x12 [drm]
T1499; ? drm_client_modeset_commit_atomic+0x1c6/0x210 [drm]
T1499; ? drm_client_modeset_commit_locked+0x56/0x160 [drm]
T1499; ? __drm_fb_helper_restore_fbdev_mode_unlocked.part.0+0x22/0x80 [drm=
_kms_helper]
T1499; ? drm_fb_helper_set_par+0x52/0x70 [drm_kms_helper]
T1499; ? fb_set_var+0x234/0x3e0
T1499; ? prepend_copy+0x10/0x40
T1499; ? prepend_path+0x214/0x340
T1499; ? aa_audit_file+0x6e/0x1d0
T1499; ? mas_wr_node_store+0x1f2/0x390
T1499; ? fbcon_blank+0x1e4/0x2f0
T1499; ? do_unblank_screen+0xc3/0x1b0
T1499; ? down+0x19/0x60
T1499; ? vt_ioctl+0x563/0x13a0
T1499; ? rt_spin_lock+0x35/0x120
T1499; ? fsnotify_grab_connector+0x45/0x80
T1499; ? rt_spin_unlock+0x5a/0xa0
T1499; ? tty_ioctl+0xdf/0x960
T1499; ? __memcg_slab_free_hook+0xd0/0x120
T1499; ? rt_spin_unlock+0x5a/0xa0
T1499; ? kmem_cache_free+0x210/0x420
T1499; ? __x64_sys_ioctl+0x92/0xe0
T1499; ? do_syscall_64+0x118/0x5e0
T1499; ? do_syscall_64+0x574/0x5e0
T1499; ? filename_unlinkat+0xd2/0x290
T1499; ? rt_spin_unlock+0x5a/0xa0
T1499; ? kmem_cache_free+0x210/0x420
T1499; ? do_syscall_64+0x574/0x5e0
T1499; ? obj_cgroup_uncharge_pages+0x58/0xd0
T1499; ? __memcg_slab_free_hook+0xd0/0x120
T1499; ? rt_spin_unlock+0x5a/0xa0
T1499; ? do_wp_page+0x7f2/0xee0
T1499; ? rt_spin_unlock+0x5a/0xa0
T1499; ? refill_obj_stock+0x1be/0x340
T1499; ? __handle_mm_fault+0x393/0x3f0
T1499; ? do_epoll_ctl+0x2a2/0xe00
T1499; ? refill_obj_stock+0x1be/0x340
T1499; ? count_memcg_events+0x66/0x100
T1499; ? handle_mm_fault+0x1b4/0x2b0
T1499; ? do_user_addr_fault+0x203/0x640
T1499; ? irqentry_exit+0x325/0x560
T1499; ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
T1499; </TASK>
T1499;---[ end trace 0000000000000000 ]---
T1265;wlp9s0: deauthenticating from 54:67:51:3d:a2:d2 by local choice (Rea=
son: 3=3DDEAUTH_LEAVING)
T5206;EXT4-fs (nvme0n1p5): unmounting filesystem 15783f8d-d7dd-4c1a-a7f8-8=
4d944f03886.
T5205;EXT4-fs (nvme0n1p4): unmounting filesystem ab8e4bed-5cab-4ae8-875a-8=
a42e075b551.
T1;systemd-shutdown[1]: Syncing filesystems and block devices.
T1;systemd-shutdown[1]: Sending SIGTERM to remaining processes...
T754;systemd-journald[754]: Received SIGTERM from PID 1 (systemd-shutdow).
T1;systemd-shutdown[1]: Sending SIGKILL to remaining processes...
T1;systemd-shutdown[1]: Unmounting file systems.
T5222;(sd-umount)[5222]: Unmounting '/run/credentials/systemd-journald.ser=
vice'.
T5224;(sd-remount)[5224]: Remounting '/' read-only with options 'errors=3D=
remount-ro'.
T5224;EXT4-fs (nvme0n1p2): re-mounted 3d5cdc5d-1902-40bf-9e16-ca819372d350=
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
T1;systemd-shutdown[1]: All filesystems, swaps, loop devices, MD devices a=
nd DM devices detached.
T1;systemd-shutdown[1]: Syncing filesystems and block devices.
T1;systemd-shutdown[1]

Which shows that the fix in commit 8bf0cb97edb may be incomplete.

Bert Karwatzki
