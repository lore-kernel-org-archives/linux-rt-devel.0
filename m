Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8D34963AA
	for <linux-rt-devel@lists.linux.dev>; Thu, 23 Jul 2026 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784812243; cv=none; b=hUlDGjMr/OjzolLMydUVtQrTdAU+i/O7Loy56b1H7ggFVHbS0rjI7ABtGby0dRzAFmwc8mq+SL/WNYiyc4PpNZCnL7B7r+GIJ5BzAHhs1gonDCrE7H7peyRN0ok84cxFxrDvO0NEz4uGXRYrScJDZHL66f0i8wkDmiw1cnHkzCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784812243; c=relaxed/simple;
	bh=/kbUKe6YdNYEIumAhMYXQk8dAWcOkWfQqHU0hWGdMSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gjr67QRT7U/U7Df7wMBaKqEH+Rq0vsb2wmHhq+cJ0nban7uaDkyUXxInTAhPl6jAS0H4mebR5pThgA3B+sRdVDSyk6D0pAUXg6Ecvdku/CDtcBvjqt0HlPf8jAukD3oRcUYbzDrRjRtn7007C3EQHID4GtCs0qmP3SLQdwIM1eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=BxFliabs; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="BxFliabs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784812203; x=1785417003; i=spasswolf@web.de;
	bh=krTN5OSRjF+KYbNd9Q2WHl5Y9svSCLcteFyfFAqzMH8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BxFliabs0dwVWL1Xkdi2hkCF2UAodFn+jkC9dH8KPUsujjtRsVefmx83FEGEFzGu
	 gM4lV6TL6ZLVlyIt0i+qO0SssqniDaC3x8AbAbQuCiHoFd6gktDNb4Yc54P2YP/HM
	 jo2nuk8t3gGZLywrYoKHxmTrK3uIAHHc+Iqga9hPhCziUK5OQE0ZUT9TzQBkYOwt1
	 +TImRrfmvCDgIxjvsCW6LEnjTOMsM7wPSo+m5UbkGa8Vi/IHq5VGEopZlOR514YiB
	 cAarWbZH24s8B6A0tvYti0inC3N4SpoIGwVvHA5VmWOkGpLTRe9DZfSM5w5Ctue3I
	 huJjM7pGXc1I4ScNgA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKuON-1wYwpq1V7d-00SK1C; Thu, 23
 Jul 2026 15:10:03 +0200
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
Subject: [Re] kernel panic during shutdown in v7.2-rc{3,4} and next-20260722 with PREEMPT_RT
Date: Thu, 23 Jul 2026 15:10:01 +0200
Message-ID: <20260723131001.11565-1-spasswolf@web.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723124353.13040-1-spasswolf@web.de>
References: 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gPMg2U6cWLtzL75vQ+8RD58uRyWsMTO1VzQQWiFdEUmRAGC3eQD
 0qFl1VllFFR/aWgH5jHF+wllIqyHml7A+OTvfJW93K0H5ljX+iedd/iVVXoTeBrnkUwe/xN
 T4HG6cErKz0kHV3satqlaRAhrWv8JRSNbfE2YVnETf5rBSwsY5bWpQaoajL8DHAkdJ9YXlb
 dj0fkcsZVODTzQOPcxaqQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CZLEXlwAu0U=;KVHLPmTMgO/AIAl2v74WYwVDu/5
 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
 SlxAfkrIZpdQ

I was able to gather the panic error message from a failed shutdown via ne=
tconsole,
this time the kernel used was v7.2-rc3:

T6298;netconsole: network logging started
T6298;netconsole-setup: Test log message to verify netconsole configuratio=
n.
T1575;BUG: scheduling while atomic: Xorg/1575/0x00000003
T1575,ncfrag=3D0/979;Modules linked in: netconsole ccm snd_seq_dummy snd_h=
rtimer snd_seq nls_ascii nls_cp437 vfat fat joydev snd_usb_audio mt7925e m=
t7925_common snd_usbmidi_lib snd_ump mt792x_lib snd_rawmidi mt76_connac_li=
b snd_seq_device intel_rapl_msr iosf_mbi mt76 intel_rapl_common rapl mac80=
211 snd_hda_codec_atihdmi snd_hda_codec_hdmi pcspkr wmi_bmof snd_hda_intel=
 snd_hda_codec libarc4 snd_hda_core cfg80211 snd_intel_dspcfg snd_hwdep sn=
d_pcm spd5118 regmap_i2c snd_timer snd rfkill soundcore aead evdev k10temp=
 ccp nct6775 nct6775_core hwmon_vid configfs efi_pstore efivarfs autofs4 e=
xt4 mbcache jbd2 amdgpu hid_generic usbhid hid drm_client_lib i2c_algo_bit=
 drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper mfd_core drm_pa=
nel_backlight_quirks gpu_sched amdxcp drm_display_helper ahci libahci xhci=
_pci libata xhci_hcd drm_kms_helper drm scsi_mod igc nvme usbcore cec scsi=
_common nvme_core crc16 video nvme_keyring gpio_amdpt i2c_piix4 nvme_auth =
usb_common gpi
T1575,ncfrag=3D955/979;o_generic i2c_smbus wmi
T1575;CPU: 16 UID: 0 PID: 1575 Comm: Xorg Not tainted 7.2.0-rc3-stable #12=
55 PREEMPT_{RT,(full)}=20
T1575;Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI=
, BIOS 1627 02/05/2026
T1575;Call Trace:
T1575; <TASK>
T1575; ? dump_stack_lvl+0x4b/0x70
T1575; ? __schedule_bug.cold+0x3e/0x4a
T1575; ? __schedule+0xf64/0x16f0
T1575; ? schedule_rtlock+0x15/0x30
T1575; ? rtlock_slowlock_locked+0x30c/0xe50
T1575; ? rt_spin_lock+0xc3/0x120
T1575; ? get_page_from_freelist+0x22e/0x1640
T1575; ? __alloc_frozen_pages_noprof+0x146/0x2b0
T1575; ? ___kmalloc_large_node+0xae/0xd0
T1575; ? __kvmalloc_node_noprof+0x36c/0x580
T1575; ? dc_create_plane_state+0x24/0x80 [amdgpu]
T1575; ? dc_create_plane_state+0x24/0x80 [amdgpu]
T1575; ? dc_state_create_phantom_plane+0x15/0x50 [amdgpu]
T1575; ? dml21_handle_phantom_streams_planes+0x292/0x510 [amdgpu]
T1575; ? dml21_mode_check_and_programming+0x157/0x7e0 [amdgpu]
T1575; ? try_to_wake_up+0x120/0x530
T1575; ? rt_mutex_setprio+0x61/0x340
T1575; ? calculate_plane_rec_in_timing_active+0x142/0x1f0 [amdgpu]
T1575; ? spl_calculate_number_of_taps.constprop.0.isra.0+0x142/0xf00 [amdg=
pu]
T1575; ? spl_calculate_number_of_taps.constprop.0.isra.0+0xed4/0xf00 [amdg=
pu]
T1575; ? dcn401_validate_bandwidth+0xb8/0x1f0 [amdgpu]
T1575; ? dc_validate_with_context+0x5ed/0x6b0 [amdgpu]
T1575; ? dc_commit_streams+0x27c/0x4e0 [amdgpu]
T1575; ? amdgpu_dm_atomic_commit_tail+0x61f/0x3650 [amdgpu]
T1575; ? generic_reg_get+0x1c/0x30 [amdgpu]
T1575; ? optc1_get_crtc_scanoutpos+0x5f/0xa0 [amdgpu]
T1575; ? dc_stream_get_scanoutpos+0x7a/0xc0 [amdgpu]
T1575; ? amdgpu_display_get_crtc_scanoutpos+0xa5/0x1c0 [amdgpu]
T1575; ? amdgpu_display_crtc_idx_to_irq_type+0x30/0x30 [amdgpu]
T1575; ? amdgpu_crtc_get_scanout_position+0x23/0x30 [amdgpu]
T1575; ? drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x180/0x3b0 =
[drm]
T1575; ? wait_for_completion_timeout+0x127/0x170
T1575; ? drm_crtc_get_last_vbltimestamp+0x50/0x80 [drm]
T1575; ? commit_tail+0xad/0x140 [drm_kms_helper]
T1575; ? drm_atomic_helper_commit+0x137/0x180 [drm_kms_helper]
T1575; ? drm_atomic_commit+0xac/0xe0 [drm]
T1575; ? __drm_universal_plane_init.cold+0x11/0x11 [drm]
T1575; ? drm_atomic_helper_set_config+0x6f/0xb0 [drm_kms_helper]
T1575; ? drm_mode_setcrtc+0x443/0x8b0 [drm]
T1575; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1575; ? drm_ioctl_kernel+0xa1/0xf0 [drm]
T1575; ? drm_ioctl+0x27f/0x500 [drm]
T1575; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1575; ? amdgpu_drm_ioctl+0x45/0x80 [amdgpu]
T1575; ? __x64_sys_ioctl+0x92/0xe0
T1575; ? do_syscall_64+0xdd/0x5d0
T1575; ? do_syscall_64+0x94/0x5d0
T1575; ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
T1575; </TASK>
T1575;------------[ cut here ]------------
T1575;WARNING: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:12=
6 at dc_fpu_end+0x36/0x40 [amdgpu], CPU#22: Xorg/1575
T1575,ncfrag=3D0/979;Modules linked in: netconsole ccm snd_seq_dummy snd_h=
rtimer snd_seq nls_ascii nls_cp437 vfat fat joydev snd_usb_audio mt7925e m=
t7925_common snd_usbmidi_lib snd_ump mt792x_lib snd_rawmidi mt76_connac_li=
b snd_seq_device intel_rapl_msr iosf_mbi mt76 intel_rapl_common rapl mac80=
211 snd_hda_codec_atihdmi snd_hda_codec_hdmi pcspkr wmi_bmof snd_hda_intel=
 snd_hda_codec libarc4 snd_hda_core cfg80211 snd_intel_dspcfg snd_hwdep sn=
d_pcm spd5118 regmap_i2c snd_timer snd rfkill soundcore aead evdev k10temp=
 ccp nct6775 nct6775_core hwmon_vid configfs efi_pstore efivarfs autofs4 e=
xt4 mbcache jbd2 amdgpu hid_generic usbhid hid drm_client_lib i2c_algo_bit=
 drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper mfd_core drm_pa=
nel_backlight_quirks gpu_sched amdxcp drm_display_helper ahci libahci xhci=
_pci libata xhci_hcd drm_kms_helper drm scsi_mod igc nvme usbcore cec scsi=
_common nvme_core crc16 video nvme_keyring gpio_amdpt i2c_piix4 nvme_auth =
usb_common gpi
T1575,ncfrag=3D955/979;o_generic i2c_smbus wmi
T1575;CPU: 22 UID: 0 PID: 1575 Comm: Xorg Tainted: G        W           7.=
2.0-rc3-stable #1255 PREEMPT_{RT,(full)}=20
T1575;Tainted: [W]=3DWARN
T1575;Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI=
, BIOS 1627 02/05/2026
T1575;RIP: 0010:dc_fpu_end+0x36/0x40 [amdgpu]
T1575;Code: 05 cf e5 16 e6 ff c8 74 10 78 1f 65 ff 0d f2 d5 15 e6 74 0c c3=
 cc cc cc cc e8 16 9c 12 e5 eb eb e8 6f 10 11 e5 c3 cc cc cc cc <0f> 0b eb=
 dd 66 0f 1f 44 00 00 41 56 41 55 41 54 55 53 48 83 ec 10
T1575;RSP: 0018:ffffa11ac5bfb638 EFLAGS: 00010296
T1575;RAX: 00000000ffffffff RBX: ffff9490f7480000 RCX: 0000000000000008
T1575;RDX: 0000000000000000 RSI: 0000000000000719 RDI: ffffffffc15b3550
T1575;RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000001
T1575;R10: ffff9490f7480000 R11: 0000000000000002 R12: ffff948e09668000
T1575;R13: ffff948e11400000 R14: 0000000000000000 R15: 0000000000000001
T1575;FS:  00007f2b496ccb80(0000) GS:ffff949d96af5000(0000) knlGS:00000000=
00000000
T1575;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
T1575;CR2: 0000557ef27b3000 CR3: 000000011543b000 CR4: 0000000000f50ef0
T1575;PKRU: 55555554
T1575;Call Trace:
T1575; <TASK>
T1575; ? dcn401_validate_bandwidth+0xd1/0x1f0 [amdgpu]
T1575; ? dc_validate_with_context+0x5ed/0x6b0 [amdgpu]
T1575; ? dc_commit_streams+0x27c/0x4e0 [amdgpu]
T1575; ? amdgpu_dm_atomic_commit_tail+0x61f/0x3650 [amdgpu]
T1575; ? generic_reg_get+0x1c/0x30 [amdgpu]
T1575; ? optc1_get_crtc_scanoutpos+0x5f/0xa0 [amdgpu]
T1575; ? dc_stream_get_scanoutpos+0x7a/0xc0 [amdgpu]
T1575; ? amdgpu_display_get_crtc_scanoutpos+0xa5/0x1c0 [amdgpu]
T1575; ? amdgpu_display_crtc_idx_to_irq_type+0x30/0x30 [amdgpu]
T1575; ? amdgpu_crtc_get_scanout_position+0x23/0x30 [amdgpu]
T1575; ? drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x180/0x3b0 =
[drm]
T1575; ? wait_for_completion_timeout+0x127/0x170
T1575; ? drm_crtc_get_last_vbltimestamp+0x50/0x80 [drm]
T1575; ? commit_tail+0xad/0x140 [drm_kms_helper]
T1575; ? drm_atomic_helper_commit+0x137/0x180 [drm_kms_helper]
T1575; ? drm_atomic_commit+0xac/0xe0 [drm]
T1575; ? __drm_universal_plane_init.cold+0x11/0x11 [drm]
T1575; ? drm_atomic_helper_set_config+0x6f/0xb0 [drm_kms_helper]
T1575; ? drm_mode_setcrtc+0x443/0x8b0 [drm]
T1575; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1575; ? drm_ioctl_kernel+0xa1/0xf0 [drm]
T1575; ? drm_ioctl+0x27f/0x500 [drm]
T1575; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1575; ? amdgpu_drm_ioctl+0x45/0x80 [amdgpu]
T1575; ? __x64_sys_ioctl+0x92/0xe0
T1575; ? do_syscall_64+0xdd/0x5d0
T1575; ? do_syscall_64+0x94/0x5d0
T1575; ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
T1575; </TASK>
T1575;---[ end trace 0000000000000000 ]---
T1575;------------[ cut here ]------------
T1575;WARNING: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:97=
 at dc_fpu_begin+0x4f/0x60 [amdgpu], CPU#17: Xorg/1575
T1575,ncfrag=3D0/979;Modules linked in: netconsole ccm snd_seq_dummy snd_h=
rtimer snd_seq nls_ascii nls_cp437 vfat fat joydev snd_usb_audio mt7925e m=
t7925_common snd_usbmidi_lib snd_ump mt792x_lib snd_rawmidi mt76_connac_li=
b snd_seq_device intel_rapl_msr iosf_mbi mt76 intel_rapl_common rapl mac80=
211 snd_hda_codec_atihdmi snd_hda_codec_hdmi pcspkr wmi_bmof snd_hda_intel=
 snd_hda_codec libarc4 snd_hda_core cfg80211 snd_intel_dspcfg snd_hwdep sn=
d_pcm spd5118 regmap_i2c snd_timer snd rfkill soundcore aead evdev k10temp=
 ccp nct6775 nct6775_core hwmon_vid configfs efi_pstore efivarfs autofs4 e=
xt4 mbcache jbd2 amdgpu hid_generic usbhid hid drm_client_lib i2c_algo_bit=
 drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper mfd_core drm_pa=
nel_backlight_quirks gpu_sched amdxcp drm_display_helper ahci libahci xhci=
_pci libata xhci_hcd drm_kms_helper drm scsi_mod igc nvme usbcore cec scsi=
_common nvme_core crc16 video nvme_keyring gpio_amdpt i2c_piix4 nvme_auth =
usb_common gpi
T1575,ncfrag=3D955/979;o_generic i2c_smbus wmi
T1575;CPU: 17 UID: 0 PID: 1575 Comm: Xorg Tainted: G        W           7.=
2.0-rc3-stable #1255 PREEMPT_{RT,(full)}=20
T1575;Tainted: [W]=3DWARN
T1575;Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI=
, BIOS 1627 02/05/2026
T1575;RIP: 0010:dc_fpu_begin+0x4f/0x60 [amdgpu]
T1575;Code: d0 75 27 65 ff 05 41 d6 15 e6 b8 01 00 00 00 65 0f c1 05 04 e6=
 16 e6 85 c0 74 05 c3 cc cc cc cc bf 02 00 00 00 e9 d1 9c 12 e5 <0f> 0b eb=
 d5 66 90 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 d6 b8
T1575;RSP: 0018:ffffa11ac5bfb6c8 EFLAGS: 00010206
T1575;RAX: 0000000000ff0000 RBX: ffff949040380000 RCX: ffff9490a92f96a0
T1575;RDX: 0000000000ff0000 RSI: 000000000000011f RDI: ffffffffc15de7a0
T1575;RBP: ffff948e14700000 R08: ffffffffa6d02440 R09: 0000000000000006
T1575;R10: ffffffffa6eb6440 R11: 0000000000000066 R12: ffff949040380000
T1575;R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
T1575;FS:  00007f2b496ccb80(0000) GS:ffff949d969b5000(0000) knlGS:00000000=
00000000
T1575;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
T1575;CR2: 00007fb5ea0bfa7c CR3: 000000011543b000 CR4: 0000000000f50ef0
T1575;PKRU: 55555554
T1575;Call Trace:
T1575; <TASK>
T1575; ? dc_state_create_copy+0x76/0x120 [amdgpu]
T1575; ? dc_commit_state_no_check+0x271/0xe00 [amdgpu]
T1575; ? dc_commit_streams+0x2f4/0x4e0 [amdgpu]
T1575; ? amdgpu_dm_atomic_commit_tail+0x61f/0x3650 [amdgpu]
T1575; ? generic_reg_get+0x1c/0x30 [amdgpu]
T1575; ? optc1_get_crtc_scanoutpos+0x5f/0xa0 [amdgpu]
T1575; ? dc_stream_get_scanoutpos+0x7a/0xc0 [amdgpu]
T1575; ? amdgpu_display_get_crtc_scanoutpos+0xa5/0x1c0 [amdgpu]
T1575; ? amdgpu_display_crtc_idx_to_irq_type+0x30/0x30 [amdgpu]
T1575; ? amdgpu_crtc_get_scanout_position+0x23/0x30 [amdgpu]
T1575; ? drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x180/0x3b0 =
[drm]
T1575; ? wait_for_completion_timeout+0x127/0x170
T1575; ? drm_crtc_get_last_vbltimestamp+0x50/0x80 [drm]
T1575; ? commit_tail+0xad/0x140 [drm_kms_helper]
T1575; ? drm_atomic_helper_commit+0x137/0x180 [drm_kms_helper]
T1575; ? drm_atomic_commit+0xac/0xe0 [drm]
T1575; ? __drm_universal_plane_init.cold+0x11/0x11 [drm]
T1575; ? drm_atomic_helper_set_config+0x6f/0xb0 [drm_kms_helper]
T1575; ? drm_mode_setcrtc+0x443/0x8b0 [drm]
T1575; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1575; ? drm_ioctl_kernel+0xa1/0xf0 [drm]
T1575; ? drm_ioctl+0x27f/0x500 [drm]
T1575; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1575; ? amdgpu_drm_ioctl+0x45/0x80 [amdgpu]
T1575; ? __x64_sys_ioctl+0x92/0xe0
T1575; ? do_syscall_64+0xdd/0x5d0
T1575; ? do_syscall_64+0x94/0x5d0
T1575; ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
T1575; </TASK>
T1575;---[ end trace 0000000000000000 ]---
T1575;------------[ cut here ]------------
T1575;kernel BUG at mm/vmalloc.c:3206!
T1575;Oops: invalid opcode: 0000 [#1] SMP NOPTI
T1575;CPU: 17 UID: 0 PID: 1575 Comm: Xorg Tainted: G        W           7.=
2.0-rc3-stable #1255 PREEMPT_{RT,(full)}=20
T1575;Tainted: [W]=3DWARN
T1575;Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI=
, BIOS 1627 02/05/2026
T1575;RIP: 0010:__get_vm_area_node+0x113/0x130
T1575;Code: ff bd ff ff ff ff 48 0f bd e8 b8 0c 00 00 00 ff c5 39 c5 0f 4c=
 e8 b8 1e 00 00 00 39 c5 0f 4f e8 c4 e2 d1 f7 ee e9 34 ff ff ff <0f> 0b 4c=
 89 ef e8 e3 46 01 00 45 31 ed eb ae 0f 1f 00 66 66 2e 0f
T1575;RSP: 0018:ffffa11ac5bfb580 EFLAGS: 00010286
T1575;RAX: 00000000ffffffff RBX: 0000000000000001 RCX: 0000000000000022
T1575;RDX: 000000000000000c RSI: 0000000000000001 RDI: 000000000000f720
T1575;RBP: 000000000000000c R08: ffffa11ac0000000 R09: ffffc11abfffffff
T1575;R10: 00000000ffffffff R11: 0000000000000066 R12: ffff949040380000
T1575;R13: 0000000000000001 R14: 0000000000000dc0 R15: 000000000000f720
T1575;FS:  00007f2b496ccb80(0000) GS:ffff949d969b5000(0000) knlGS:00000000=
00000000
T1575;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
T1575;CR2: 00007fb5ea0bfa7c CR3: 000000011543b000 CR4: 0000000000f50ef0
T1575;PKRU: 55555554
T1575;Call Trace:
T1575; <TASK>
T1575; ? __vmalloc_node_range_noprof+0x14a/0x920
T1575; ? dml21_allocate_memory+0x124/0x180 [amdgpu]
T1575; ? dc_fpu_begin+0x51/0x60 [amdgpu]
T1575; ? dml21_allocate_memory+0x124/0x180 [amdgpu]
T1575; ? asm_exc_invalid_op+0x1a/0x20
T1575; ? __vmalloc_node_noprof+0x47/0x60
T1575; ? dml21_allocate_memory+0x124/0x180 [amdgpu]
T1575; ? dml21_allocate_memory+0x124/0x180 [amdgpu]
T1575; ? dml21_create_copy+0x16/0x40 [amdgpu]
T1575; ? dc_state_create_copy+0x89/0x120 [amdgpu]
T1575; ? dc_commit_state_no_check+0x271/0xe00 [amdgpu]
T1575; ? dc_commit_streams+0x2f4/0x4e0 [amdgpu]
T1575; ? amdgpu_dm_atomic_commit_tail+0x61f/0x3650 [amdgpu]
T1575; ? generic_reg_get+0x1c/0x30 [amdgpu]
T1575; ? optc1_get_crtc_scanoutpos+0x5f/0xa0 [amdgpu]
T1575; ? dc_stream_get_scanoutpos+0x7a/0xc0 [amdgpu]
T1575; ? amdgpu_display_get_crtc_scanoutpos+0xa5/0x1c0 [amdgpu]
T1575; ? amdgpu_display_crtc_idx_to_irq_type+0x30/0x30 [amdgpu]
T1575; ? amdgpu_crtc_get_scanout_position+0x23/0x30 [amdgpu]
T1575; ? drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x180/0x3b0 =
[drm]
T1575; ? wait_for_completion_timeout+0x127/0x170
T1575; ? drm_crtc_get_last_vbltimestamp+0x50/0x80 [drm]
T1575; ? commit_tail+0xad/0x140 [drm_kms_helper]
T1575; ? drm_atomic_helper_commit+0x137/0x180 [drm_kms_helper]
T1575; ? drm_atomic_commit+0xac/0xe0 [drm]
T1575; ? __drm_universal_plane_init.cold+0x11/0x11 [drm]
T1575; ? drm_atomic_helper_set_config+0x6f/0xb0 [drm_kms_helper]
T1575; ? drm_mode_setcrtc+0x443/0x8b0 [drm]
T1575; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1575; ? drm_ioctl_kernel+0xa1/0xf0 [drm]
T1575; ? drm_ioctl+0x27f/0x500 [drm]
T1575; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1575; ? amdgpu_drm_ioctl+0x45/0x80 [amdgpu]
T1575; ? __x64_sys_ioctl+0x92/0xe0
T1575; ? do_syscall_64+0xdd/0x5d0
T1575; ? do_syscall_64+0x94/0x5d0
T1575; ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
T1575; </TASK>
T1575,ncfrag=3D0/979;Modules linked in: netconsole ccm snd_seq_dummy snd_h=
rtimer snd_seq nls_ascii nls_cp437 vfat fat joydev snd_usb_audio mt7925e m=
t7925_common snd_usbmidi_lib snd_ump mt792x_lib snd_rawmidi mt76_connac_li=
b snd_seq_device intel_rapl_msr iosf_mbi mt76 intel_rapl_common rapl mac80=
211 snd_hda_codec_atihdmi snd_hda_codec_hdmi pcspkr wmi_bmof snd_hda_intel=
 snd_hda_codec libarc4 snd_hda_core cfg80211 snd_intel_dspcfg snd_hwdep sn=
d_pcm spd5118 regmap_i2c snd_timer snd rfkill soundcore aead evdev k10temp=
 ccp nct6775 nct6775_core hwmon_vid configfs efi_pstore efivarfs autofs4 e=
xt4 mbcache jbd2 amdgpu hid_generic usbhid hid drm_client_lib i2c_algo_bit=
 drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper mfd_core drm_pa=
nel_backlight_quirks gpu_sched amdxcp drm_display_helper ahci libahci xhci=
_pci libata xhci_hcd drm_kms_helper drm scsi_mod igc nvme usbcore cec scsi=
_common nvme_core crc16 video nvme_keyring gpio_amdpt i2c_piix4 nvme_auth =
usb_common gpi
T1575,ncfrag=3D955/979;o_generic i2c_smbus wmi
T1575;---[ end trace 0000000000000000 ]---
T1575;------------[ cut here ]------------
T1575;WARNING: kernel/printk/nbcon.c:1739 at nbcon_cpu_emergency_exit+0x85=
/0xa0, CPU#23: Xorg/1575
T1575,ncfrag=3D0/979;Modules linked in: netconsole ccm snd_seq_dummy snd_h=
rtimer snd_seq nls_ascii nls_cp437 vfat fat joydev snd_usb_audio mt7925e m=
t7925_common snd_usbmidi_lib snd_ump mt792x_lib snd_rawmidi mt76_connac_li=
b snd_seq_device intel_rapl_msr iosf_mbi mt76 intel_rapl_common rapl mac80=
211 snd_hda_codec_atihdmi snd_hda_codec_hdmi pcspkr wmi_bmof snd_hda_intel=
 snd_hda_codec libarc4 snd_hda_core cfg80211 snd_intel_dspcfg snd_hwdep sn=
d_pcm spd5118 regmap_i2c snd_timer snd rfkill soundcore aead evdev k10temp=
 ccp nct6775 nct6775_core hwmon_vid configfs efi_pstore efivarfs autofs4 e=
xt4 mbcache jbd2 amdgpu hid_generic usbhid hid drm_client_lib i2c_algo_bit=
 drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper mfd_core drm_pa=
nel_backlight_quirks gpu_sched amdxcp drm_display_helper ahci libahci xhci=
_pci libata xhci_hcd drm_kms_helper drm scsi_mod igc nvme usbcore cec scsi=
_common nvme_core crc16 video nvme_keyring gpio_amdpt i2c_piix4 nvme_auth =
usb_common gpi
T1575,ncfrag=3D955/979;o_generic i2c_smbus wmi
T1575;CPU: 23 UID: 0 PID: 1575 Comm: Xorg Tainted: G      D W           7.=
2.0-rc3-stable #1255 PREEMPT_{RT,(full)}=20
T1575;Tainted: [D]=3DDIE, [W]=3DWARN
T1575;Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI=
, BIOS 1627 02/05/2026
T1575;RIP: 0010:nbcon_cpu_emergency_exit+0x85/0xa0
T1575;Code: 75 38 48 83 c4 10 c3 cc cc cc cc 48 8d 7c 24 04 e8 e0 ef ff ff=
 80 7c 24 05 00 74 ce e8 74 fc ff ff eb c7 e8 8d 67 f2 ff eb c9 <0f> 0b 8b=
 05 43 6a fc 00 85 c0 75 a2 0f 0b eb b0 e8 16 15 8b 00 66
T1575;RSP: 0018:ffffa11ac5bfb3f8 EFLAGS: 00010246
T1575;RAX: 0000000000000000 RBX: 000000000000000b RCX: 0000000000000000
T1575;RDX: ffff949d3d9db204 RSI: 0000000000000001 RDI: ffff949d3d9db040
T1575;RBP: 0000000000000246 R08: 0000000000000000 R09: 3fffffffffffdfff
T1575;R10: ffffffffa6ed4e20 R11: ffffa11ac5bfb200 R12: ffffa11ac5bfb4d8
T1575;R13: ffffffffa60d2ad3 R14: 0000000000000002 R15: 0000000000000004
T1575;FS:  00007f2b496ccb80(0000) GS:ffff949d96b35000(0000) knlGS:00000000=
00000000
T1575;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
T1575;CR2: 0000557ef2780ef8 CR3: 000000011543b000 CR4: 0000000000f50ef0
T1575;PKRU: 55555554
T1575;Call Trace:
T1575; <TASK>
T1575; ? oops_exit.cold+0x13/0x1f
T1575; ? oops_end+0x66/0xe0
T1575; ? do_trap+0xc5/0x110
T1575; ? do_error_trap+0x60/0x80
T1575; ? __get_vm_area_node+0x113/0x130
T1575; ? exc_invalid_op+0x4f/0x70
T1575; ? __get_vm_area_node+0x113/0x130
T1575; ? asm_exc_invalid_op+0x1a/0x20
T1575; ? __get_vm_area_node+0x113/0x130
T1575; ? __vmalloc_node_range_noprof+0x14a/0x920
T1575; ? dml21_allocate_memory+0x124/0x180 [amdgpu]
T1575; ? dc_fpu_begin+0x51/0x60 [amdgpu]
T1575; ? dml21_allocate_memory+0x124/0x180 [amdgpu]
T1575; ? asm_exc_invalid_op+0x1a/0x20
T1575; ? __vmalloc_node_noprof+0x47/0x60
T1575; ? dml21_allocate_memory+0x124/0x180 [amdgpu]
T1575; ? dml21_allocate_memory+0x124/0x180 [amdgpu]
T1575; ? dml21_create_copy+0x16/0x40 [amdgpu]
T1575; ? dc_state_create_copy+0x89/0x120 [amdgpu]
T1575; ? dc_commit_state_no_check+0x271/0xe00 [amdgpu]
T1575; ? dc_commit_streams+0x2f4/0x4e0 [amdgpu]
T1575; ? amdgpu_dm_atomic_commit_tail+0x61f/0x3650 [amdgpu]
T1575; ? generic_reg_get+0x1c/0x30 [amdgpu]
T1575; ? optc1_get_crtc_scanoutpos+0x5f/0xa0 [amdgpu]
T1575; ? dc_stream_get_scanoutpos+0x7a/0xc0 [amdgpu]
T1575; ? amdgpu_display_get_crtc_scanoutpos+0xa5/0x1c0 [amdgpu]
T1575; ? amdgpu_display_crtc_idx_to_irq_type+0x30/0x30 [amdgpu]
T1575; ? amdgpu_crtc_get_scanout_position+0x23/0x30 [amdgpu]
T1575; ? drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x180/0x3b0 =
[drm]
T1575; ? wait_for_completion_timeout+0x127/0x170
T1575; ? drm_crtc_get_last_vbltimestamp+0x50/0x80 [drm]
T1575; ? commit_tail+0xad/0x140 [drm_kms_helper]
T1575; ? drm_atomic_helper_commit+0x137/0x180 [drm_kms_helper]
T1575; ? drm_atomic_commit+0xac/0xe0 [drm]
T1575; ? __drm_universal_plane_init.cold+0x11/0x11 [drm]
T1575; ? drm_atomic_helper_set_config+0x6f/0xb0 [drm_kms_helper]
T1575; ? drm_mode_setcrtc+0x443/0x8b0 [drm]
T1575; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1575; ? drm_ioctl_kernel+0xa1/0xf0 [drm]
T1575; ? drm_ioctl+0x27f/0x500 [drm]
T1575; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1575; ? amdgpu_drm_ioctl+0x45/0x80 [amdgpu]
T1575; ? __x64_sys_ioctl+0x92/0xe0
T1575; ? do_syscall_64+0xdd/0x5d0
T1575; ? do_syscall_64+0x94/0x5d0
T1575; ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
T1575; </TASK>
T1575;---[ end trace 0000000000000000 ]---
C23;RIP: 0010:__get_vm_area_node+0x113/0x130
C5;Code: ff bd ff ff ff ff 48 0f bd e8 b8 0c 00 00 00 ff c5 39 c5 0f 4c e8=
 b8 1e 00 00 00 39 c5 0f 4f e8 c4 e2 d1 f7 ee e9 34 ff ff ff <0f> 0b 4c 89=
 ef e8 e3 46 01 00 45 31 ed eb ae 0f 1f 00 66 66 2e 0f
C5;RSP: 0018:ffffa11ac5bfb580 EFLAGS: 00010286
C5;RAX: 00000000ffffffff RBX: 0000000000000001 RCX: 0000000000000022
C5;RDX: 000000000000000c RSI: 0000000000000001 RDI: 000000000000f720
C5;RBP: 000000000000000c R08: ffffa11ac0000000 R09: ffffc11abfffffff
C5;R10: 00000000ffffffff R11: 0000000000000066 R12: ffff949040380000
C5;R13: 0000000000000001 R14: 0000000000000dc0 R15: 000000000000f720
C5;FS:  00007f2b496ccb80(0000) GS:ffff949d966b5000(0000) knlGS:00000000000=
00000
C5;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
C5;CR2: 00007f17b8093940 CR3: 000000011543b000 CR4: 0000000000f50ef0
C5;PKRU: 55555554
T1575;Kernel panic - not syncing: Fatal exception in interrupt
T1575;Kernel Offset: 0x24c00000 from 0xffffffff81000000 (relocation range:=
 0xffffffff80000000-0xffffffffbfffffff)
T1575;---[ end Kernel panic - not syncing: Fatal exception in interrupt ]-=
=2D-


Bert Karwatzki
