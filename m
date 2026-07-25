Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24A730C168
	for <linux-rt-devel@lists.linux.dev>; Sat, 25 Jul 2026 23:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785021437; cv=none; b=u2NUOlNy4y/fC6O50CLjO+pzIojbAMGJDvD0MewtBVwCEI3AePsTIpuJXDJvBpr1aZYFvpn6D5HTjD2jf3MNYNNHJK8b0rhSAjbYsdoA5aJBJdmvVD1wMqerHZzZInfrf55yyC17lz1XsrHTigPIFpZrJJJGGL43yTpL4jZRLCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785021437; c=relaxed/simple;
	bh=8ZBG8Y44ywnfLB5qYNu9JNNbBwsf3wSMxYeb8B7alTY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UvTpZqW9JvcPa2HSS1whDDt1pKH7Sf21JsbOnsXa597KRO3j5mU8UilBF2fxuKYWefHD93ROS5DL8nvzADC81lx7A+17Hf/N4RsDOFqD1eI07V1SvvM/xExH1jeBiZR+Lc2OkmHMjc52GaKzaz8sN+hSFMx31PbQkrmc+eCgUL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=a5E1+52b; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="a5E1+52b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785021418; x=1785626218; i=spasswolf@web.de;
	bh=ECemhLsMnsm8RPwOoh8F1N3+Jb0IJr1ZXcVVCTYAFLI=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=a5E1+52bkVMbPEymq8u2o1MoAmx6zkdlUJlv/o7ohmbBGTN8DVCciAPKB4oLmRIp
	 3EbOlZA+kaKWTX9p+1ch3qXFXSrBBsgcZcZTbIitbJzPCEd9FSyTX595MD7jbGH60
	 efXpw2SRmGXKPbdaejqTsBvx6ZC0eMsRcHfJDcEf4jO6j4+Ut7rX1G7jXhpi2mx9N
	 nDEC5Z7JwE19u9j9ElAmGBBlkUFNdSpN4HzhcIM2CWaldrTkLMDD/8ZQkdIMLd0by
	 olN8RWJ4RL3lQA7dhvhBWxDg3ViBd4b97sdZEO3r2Z5XTsbWQ0Mm3bsBgAvr5YfM0
	 KvRQsBRCJktwt3LYag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MAcpW-1whD5m0cR6-000zWf; Sun, 26
 Jul 2026 01:16:58 +0200
Message-ID: <4af8467060c5ee136c2b99ab855a007fec4e8c6c.camel@web.de>
Subject: Re: [Re] kernel panic during shutdown in  next-20260722
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org, Rafal Ostrowski <rafal.ostrowski@amd.com>
Cc: linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Thomas Gleixner	 <tglx@linutronix.de>,
 spasswolf@web.de
Date: Sun, 26 Jul 2026 01:16:56 +0200
In-Reply-To: <dc5f1cfb267b0fb522b8aaa236b71b23e236df4d.camel@web.de>
References: <20260723131001.11565-1-spasswolf@web.de>
						 <d24a136539c5931984f4855ad6596ca7aee8ebe2.camel@web.de>
				 <1a0800888c2fcd42f1fcd661d8f6f50580ac2fd4.camel@web.de>
			 <4d7c2dd588cd77d1d112da473f2a262d22051d57.camel@web.de>
		 <3c1be47abfcc907e7c1f9696cb25a24c93415a28.camel@web.de>
	 <dc5f1cfb267b0fb522b8aaa236b71b23e236df4d.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WN2zWF1+GHDUpavR0XFITDpph02Wgfwq0/yiYyeKPK8UyOFFvXp
 wwSNk7I2afG7LV6dohMknS54B8UzJJw70NiA3wXUOss0Wsvsv+six7vGtmunc5gkACwpRrQ
 oKiYuSjEgXWeMmv1LdEjtGKPeOcSuXylAHBM7vCEr9G2cYeFP0etxPzfV9LZx04WfPOyKBm
 d/E/Z4pCLe1zQEv9fudLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:anZvo36EqNk=;MZ7uIcpNFrzQP+8y26C0res26Cp
 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
 =

Am Samstag, dem 25.07.2026 um 21:58 +0200 schrieb Bert Karwatzki:
> Am Freitag, dem 24.07.2026 um 17:08 +0200 schrieb Bert Karwatzki:
> >=20
> >=20
> > 2) The "scheduling while atomic" errors which occur in v7.2-rc4 and ea=
rlier, once I figure out
> > these I'll contiue here (v6.19 is free from these errors)
> >=20
> > Bert Karwatzki
>=20
> To figure out the "scheduling while atomic" errors when rebooting from v=
7.1 I first retested
>=20
> commit 8bf0cb97edb ("drm/amd/display: Move dml2_destroy to non-FPU compi=
lation unit")
>=20
> which was supposed to fix "scheduling while atomic" errors introduced by=
 these patches:
>=20
> 32c1c35b6d8b drm/amd/display: Move FPU Guards From DML To DC - Part 3
> 4bb2f0721ed8 drm/amd/display: Move FPU Guards From DML To DC - Part 2
> 3539437f354b drm/amd/display: Move FPU Guards From DML To DC - Part 1
>=20
> https://lore.kernel.org/lkml/20260409131411.10598-1-spasswolf@web.de/
>=20
>=20
> Which shows that the fix in commit 8bf0cb97edb may be incomplete.
>=20
> Bert Karwatzki

I did yet another test of
commit 8bf0cb97edb ("drm/amd/display: Move dml2_destroy to non-FPU compila=
tion unit")
this time with CONFIG_LOCKDEP=3Dy and got a kernel panic:

T4648;netconsole: network logging started
T4648;netconsole-setup: Test log message to verify netconsole configuratio=
n.
T1508;BUG: scheduling while atomic: Xorg/1508/0x00000003
T1508;4 locks held by Xorg/1508:
T1508; #0: ffffb949cd76b9f8 (crtc_ww_class_acquire){+.+.}-{0:0}, at: set_p=
roperty_atomic+0x51/0x150 [drm]
T1508; #1: ffffb949cd76ba20 (crtc_ww_class_mutex){+.+.}-{4:4}, at: set_pro=
perty_atomic+0x51/0x150 [drm]
T1508; #2: ffff980422565478 (&adev->dm.dc_lock){+.+.}-{4:4}, at: amdgpu_dm=
_atomic_commit_tail+0x120a/0x3460 [amdgpu]
T1508; #3: ffffffff9cdbcc50 (&zone->lock){+.+.}-{3:3}, at: get_page_from_f=
reelist+0x261/0x19f0
T1508,ncfrag=3D0/979;Modules linked in: netconsole ccm snd_seq_dummy snd_h=
rtimer snd_seq nls_ascii nls_cp437 vfat fat mt7925e mt7925_common snd_hda_=
codec_atihdmi
joydev snd_usb_audio mt792x_lib snd_hda_codec_hdmi intel_rapl_msr mt76_con=
nac_lib snd_usbmidi_lib snd_ump intel_rapl_common mt76 snd_rawmidi iosf_mb=
i
snd_seq_device snd_hda_intel mac80211 rapl wmi_bmof snd_hda_codec snd_hda_=
core libarc4 snd_intel_dspcfg spd5118 snd_hwdep cfg80211 regmap_i2c snd_pc=
m pcspkr
snd_timer snd rfkill soundcore evdev ccp k10temp nct6775 nct6775_core hwmo=
n_vid efi_pstore configfs efivarfs autofs4 ext4 mbcache jbd2 amdgpu hid_ge=
neric usbhid
hid drm_client_lib i2c_algo_bit drm_buddy drm_ttm_helper ttm drm_exec drm_=
suballoc_helper mfd_core drm_panel_backlight_quirks gpu_sched amdxcp
drm_display_helper drm_kms_helper ahci libahci drm libata scsi_mod cec xhc=
i_pci igc scsi_common crc16 xhci_hcd nvme nvme_core video usbcore nvme_key=
ring
nvme_auth hkd
T1508,ncfrag=3D918/979;f usb_common i2c_piix4 gpio_amdpt gpio_generic i2c_=
smbus wmi
T1508;CPU: 23 UID: 0 PID: 1508 Comm: Xorg Tainted: G        W           7.=
0.0-rc7-lockdep-01908-g8bf0cb97edb6 #1264 PREEMPT_{RT,(full)}=20
T1508;Tainted: [W]=3DWARN
T1508;Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI=
, BIOS 1627 02/05/2026
T1508;Call Trace:
T1508; <TASK>
T1508; ? dump_stack_lvl+0x5b/0x80
T1508; ? __schedule_bug.cold+0x5a/0x67
T1508; ? __schedule+0x1468/0x1ae0
T1508; ? rtlock_slowlock_locked+0x281/0x1aa0
T1508; ? mark_held_locks+0x40/0x70
T1508; ? schedule_rtlock+0x15/0x30
T1508; ? rtlock_slowlock_locked+0x5b4/0x1aa0
T1508; ? lock_acquire+0xbf/0x2e0
T1508; ? rt_spin_lock+0x85/0x1b0
T1508; ? get_page_from_freelist+0x261/0x19f0
T1508; ? __lock_acquire+0x49a/0x2590
T1508; ? dc_link_get_highest_encoding_format+0x61/0xb0 [amdgpu]
T1508; ? __alloc_frozen_pages_noprof+0x158/0x370
T1508; ? ___kmalloc_large_node+0xd7/0xf0
T1508; ? __kmalloc_large_node_noprof+0x1b/0x130
T1508; ? __kvmalloc_node_noprof+0x4ad/0x730
T1508; ? dc_create_plane_state+0x24/0x80 [amdgpu]
T1508; ? dc_create_plane_state+0x24/0x80 [amdgpu]
T1508; ? dc_state_create_phantom_plane+0x15/0x50 [amdgpu]
T1508; ? dml21_handle_phantom_streams_planes+0x292/0x510 [amdgpu]
T1508; ? dml21_mode_check_and_programming+0x157/0x7e0 [amdgpu]
T1508; ? spl_set_filters_data+0xbc/0xd0 [amdgpu]
T1508; ? spl_calculate_scaler_params+0x39d/0x1c00 [amdgpu]
T1508; ? dc_state_remove_plane+0xbf/0x160 [amdgpu]
T1508; ? dcn401_validate_bandwidth+0xb8/0x1f0 [amdgpu]
T1508; ? update_planes_and_stream_state+0xeb5/0x1520 [amdgpu]
T1508; ? __lock_acquire+0x49a/0x2590
T1508; ? update_planes_and_stream_prepare_v3+0xb3/0x430 [amdgpu]
T1508; ? dc_update_planes_and_stream+0x87/0x130 [amdgpu]
T1508; ? amdgpu_dm_atomic_commit_tail+0x126b/0x3460 [amdgpu]
T1508; ? commit_tail+0x9d/0x130 [drm_kms_helper]
T1508; ? drm_atomic_helper_commit+0x15a/0x1a0 [drm_kms_helper]
T1508; ? drm_atomic_commit+0xac/0xe0 [drm]
T1508; ? __drm_universal_plane_init.cold+0x17/0x17 [drm]
T1508; ? set_property_atomic+0x82/0x150 [drm]
T1508; ? drm_mode_obj_find_prop_id+0x60/0x60 [drm]
T1508; ? drm_mode_obj_set_property_ioctl+0xe6/0x150 [drm]
T1508; ? drm_ioctl_kernel+0xa7/0x100 [drm]
T1508; ? drm_ioctl+0x288/0x510 [drm]
T1508; ? drm_mode_obj_find_prop_id+0x60/0x60 [drm]
T1508; ? rt_mutex_slowunlock+0x3bd/0x420
T1508; ? amdgpu_drm_ioctl+0x4b/0x80 [amdgpu]
T1508; ? __x64_sys_ioctl+0x95/0xe0
T1508; ? do_syscall_64+0x129/0x6b0
T1508; ? kmem_cache_free+0x179/0x4c0
T1508; ? lockdep_hardirqs_on_prepare+0xd7/0x180
T1508; ? trace_hardirqs_on_prepare+0xdc/0x100
T1508; ? do_syscall_64+0x238/0x6b0
T1508; ? trace_hardirqs_off+0x4e/0xf0
T1508; ? exit_to_user_mode_loop+0xf8/0x460
T1508; ? trace_hardirqs_on_prepare+0xdc/0x100
T1508; ? do_syscall_64+0x238/0x6b0
T1508; ? vfs_writev+0x9a/0x490
T1508; ? find_held_lock+0x2b/0x80
T1508; ? __fget_files+0xbf/0x190
T1508; ? lock_release+0xd3/0x2f0
T1508; ? do_writev+0xf4/0x110
T1508; ? trace_hardirqs_on_prepare+0xdc/0x100
T1508; ? do_syscall_64+0x238/0x6b0
T1508; ? flush_tlb_func+0x74/0x340
T1508; ? do_writev+0xf4/0x110
T1508; ? trace_hardirqs_on_prepare+0xdc/0x100
T1508; ? do_syscall_64+0x238/0x6b0
T1508; ? trace_hardirqs_on_prepare+0xdc/0x100
T1508; ? lockdep_hardirqs_on_prepare+0xd7/0x180
T1508; ? irqentry_exit+0xbd/0x5a0
T1508; ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
T1508; </TASK>
C23;------------[ cut here ]------------
T1508;WARNING: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:97=
 at dc_fpu_begin+0x160/0x170 [amdgpu], CPU#23: Xorg/1508
T1508,ncfrag=3D0/979;Modules linked in: netconsole ccm snd_seq_dummy snd_h=
rtimer snd_seq nls_ascii nls_cp437 vfat fat mt7925e mt7925_common snd_hda_=
codec_atihdmi
joydev snd_usb_audio mt792x_lib snd_hda_codec_hdmi intel_rapl_msr mt76_con=
nac_lib snd_usbmidi_lib snd_ump intel_rapl_common mt76 snd_rawmidi iosf_mb=
i
snd_seq_device snd_hda_intel mac80211 rapl wmi_bmof snd_hda_codec snd_hda_=
core libarc4 snd_intel_dspcfg spd5118 snd_hwdep cfg80211 regmap_i2c snd_pc=
m pcspkr
snd_timer snd rfkill soundcore evdev ccp k10temp nct6775 nct6775_core hwmo=
n_vid efi_pstore configfs efivarfs autofs4 ext4 mbcache jbd2 amdgpu hid_ge=
neric usbhid
hid drm_client_lib i2c_algo_bit drm_buddy drm_ttm_helper ttm drm_exec drm_=
suballoc_helper mfd_core drm_panel_backlight_quirks gpu_sched amdxcp
drm_display_helper drm_kms_helper ahci libahci drm libata scsi_mod cec xhc=
i_pci igc scsi_common crc16 xhci_hcd nvme nvme_core video usbcore nvme_key=
ring
nvme_auth hkd
T1508,ncfrag=3D918/979;f usb_common i2c_piix4 gpio_amdpt gpio_generic i2c_=
smbus wmi
T1508;CPU: 23 UID: 0 PID: 1508 Comm: Xorg Tainted: G        W           7.=
0.0-rc7-lockdep-01908-g8bf0cb97edb6 #1264 PREEMPT_{RT,(full)}=20
T1508;Tainted: [W]=3DWARN
T1508;Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI=
, BIOS 1627 02/05/2026
T1508;RIP: 0010:dc_fpu_begin+0x160/0x170 [amdgpu]
T1508;Code: ff bf 02 00 00 00 89 4c 24 14 4c 89 4c 24 08 44 89 04 24 e8 c2=
 63 12 db 8b 4c 24 14 4c 8b 4c 24 08 44 8b 04 24 e9 f5 fe ff ff <0f> 0b e9=
 ce fe ff ff
66 0f 1f 84 00 00 00 00 00 0f 1f 40 d6 41 56
T1508;RSP: 0018:ffffb949cd76b570 EFLAGS: 00010206
T1508;RAX: 0000000000ff0000 RBX: ffff980423000000 RCX: 00000000000006c8
T1508;RDX: 0000000000ff0000 RSI: 00000000000006c8 RDI: ffffffffc11c3960
T1508;RBP: ffff980522a00000 R08: 0000000000005183 R09: ffffffffc11c3960
T1508;R10: ffffb949cd76b508 R11: 0000000000000002 R12: ffff980448140000
T1508;R13: 0000000000000001 R14: ffff980423000000 R15: ffff980566daa000
T1508;FS:  00007f93c3e6fb80(0000) GS:ffff9813a0a46000(0000) knlGS:00000000=
00000000
T1508;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
T1508;CR2: 00007ff941d9d000 CR3: 000000011261e000 CR4: 0000000000f50ef0
T1508;PKRU: 55555554
T1508;Call Trace:
T1508; <TASK>
T1508; ? determine_pipe_unlock_order+0x78/0xf0 [amdgpu]
T1508; ? dcn401_prepare_mcache_programming+0x2f/0x70 [amdgpu]
T1508; ? commit_planes_for_stream+0x157/0x1870 [amdgpu]
T1508; ? update_planes_and_stream_execute_v3+0x3c/0xd0 [amdgpu]
T1508; ? dc_update_planes_and_stream+0xb6/0x130 [amdgpu]
T1508; ? amdgpu_dm_atomic_commit_tail+0x126b/0x3460 [amdgpu]
T1508; ? commit_tail+0x9d/0x130 [drm_kms_helper]
T1508; ? drm_atomic_helper_commit+0x15a/0x1a0 [drm_kms_helper]
T1508; ? drm_atomic_commit+0xac/0xe0 [drm]
T1508; ? __drm_universal_plane_init.cold+0x17/0x17 [drm]
T1508; ? set_property_atomic+0x82/0x150 [drm]
T1508; ? drm_mode_obj_find_prop_id+0x60/0x60 [drm]
T1508; ? drm_mode_obj_set_property_ioctl+0xe6/0x150 [drm]
T1508; ? drm_ioctl_kernel+0xa7/0x100 [drm]
T1508; ? drm_ioctl+0x288/0x510 [drm]
T1508; ? drm_mode_obj_find_prop_id+0x60/0x60 [drm]
T1508; ? rt_mutex_slowunlock+0x3bd/0x420
T1508; ? amdgpu_drm_ioctl+0x4b/0x80 [amdgpu]
T1508; ? __x64_sys_ioctl+0x95/0xe0
T1508; ? do_syscall_64+0x129/0x6b0
T1508; ? kmem_cache_free+0x179/0x4c0
T1508; ? lockdep_hardirqs_on_prepare+0xd7/0x180
T1508; ? trace_hardirqs_on_prepare+0xdc/0x100
T1508; ? do_syscall_64+0x238/0x6b0
T1508; ? trace_hardirqs_off+0x4e/0xf0
T1508; ? exit_to_user_mode_loop+0xf8/0x460
T1508; ? trace_hardirqs_on_prepare+0xdc/0x100
T1508; ? do_syscall_64+0x238/0x6b0
T1508; ? vfs_writev+0x9a/0x490
T1508; ? find_held_lock+0x2b/0x80
T1508; ? __fget_files+0xbf/0x190
T1508; ? lock_release+0xd3/0x2f0
T1508; ? do_writev+0xf4/0x110
T1508; ? trace_hardirqs_on_prepare+0xdc/0x100
T1508; ? do_syscall_64+0x238/0x6b0
T1508; ? flush_tlb_func+0x74/0x340
T1508; ? do_writev+0xf4/0x110
T1508; ? trace_hardirqs_on_prepare+0xdc/0x100
T1508; ? do_syscall_64+0x238/0x6b0
T1508; ? trace_hardirqs_on_prepare+0xdc/0x100
T1508; ? lockdep_hardirqs_on_prepare+0xd7/0x180
T1508; ? irqentry_exit+0xbd/0x5a0
T1508; ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
T1508; </TASK>
T1508;irq event stamp: 11300063
T1508;hardirqs last  enabled at (11300065): [<ffffffff9bb6683d>] vprintk_s=
tore+0x36d/0x5e0
T1508;hardirqs last disabled at (11300066): [<ffffffff9bb6685f>] vprintk_s=
tore+0x38f/0x5e0
T1508;softirqs last  enabled at (11293958): [<ffffffff9bacb56b>] __local_b=
h_enable_ip+0xfb/0x140
T1508;softirqs last disabled at (11293948): [<ffffffff9c49b14d>] unix_rele=
ase_sock+0xfd/0x540
T1508;---[ end trace 0000000000000000 ]---
C23;------------[ cut here ]------------
C23;kernel BUG at mm/vmalloc.c:3412!
C23;Oops: invalid opcode: 0000 [#1] SMP NOPTI
C23;CPU: 23 UID: 0 PID: 1508 Comm: Xorg Tainted: G        W           7.0.=
0-rc7-lockdep-01908-g8bf0cb97edb6 #1264 PREEMPT_{RT,(full)}=20
C23;Tainted: [W]=3DWARN
C23;Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI, =
BIOS 1627 02/05/2026
C23;RIP: 0010:vfree_atomic+0x55/0x60
C23;Code: 07 48 89 c1 f0 48 0f b1 3a 75 f3 48 85 c9 74 05 c3 cc cc cc cc 4=
8 8b 35 a1 70 c1 00 48 83 c2 08 bf 20 00 00 00 e9 cb 29 d6 ff <0f> 0b 66 0=
f 1f 84 00
00 00 00 00 f3 0f 1e fa 41 56 41 54 55 53 48
C23;RSP: 0018:ffffb949cd76b5f8 EFLAGS: 00010286
C23;RAX: 0000000000ff0000 RBX: ffffb949cdfd5000 RCX: 0000000000000183
C23;RDX: 0000000000ff0000 RSI: 000000000000003d RDI: ffffb949e08ad000
C23;RBP: ffff98058f900000 R08: 0000000000000000 R09: ffffffffc11e6d50
C23;R10: 0000000000000006 R11: ffff9804480c8ad0 R12: ffff980448140000
C23;R13: ffff980423000000 R14: 0000000000000001 R15: ffff980566daa000
C23;FS:  00007f93c3e6fb80(0000) GS:ffff9813a0a46000(0000) knlGS:0000000000=
000000
C23;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
C23;CR2: 00007ff941d9d000 CR3: 000000011261e000 CR4: 0000000000f50ef0
C23;PKRU: 55555554
C23;Call Trace:
C23; <TASK>
C23; ? dml21_destroy+0x50/0xa0 [amdgpu]
C23; ? dml2_destroy+0x59/0x60 [amdgpu]
C23; ? dc_state_free+0x31/0x70 [amdgpu]
C23; ? update_planes_and_stream_cleanup_v3+0x4f/0x3e0 [amdgpu]
C23; ? dc_update_planes_and_stream+0xc4/0x130 [amdgpu]
C23; ? amdgpu_dm_atomic_commit_tail+0x126b/0x3460 [amdgpu]
C23; ? commit_tail+0x9d/0x130 [drm_kms_helper]
C23; ? drm_atomic_helper_commit+0x15a/0x1a0 [drm_kms_helper]
C23; ? drm_atomic_commit+0xac/0xe0 [drm]
C23; ? __drm_universal_plane_init.cold+0x17/0x17 [drm]
C23; ? set_property_atomic+0x82/0x150 [drm]
C23; ? drm_mode_obj_find_prop_id+0x60/0x60 [drm]
C23; ? drm_mode_obj_set_property_ioctl+0xe6/0x150 [drm]
C23; ? drm_ioctl_kernel+0xa7/0x100 [drm]
C23; ? drm_ioctl+0x288/0x510 [drm]
C23; ? drm_mode_obj_find_prop_id+0x60/0x60 [drm]
C23; ? rt_mutex_slowunlock+0x3bd/0x420
C23; ? amdgpu_drm_ioctl+0x4b/0x80 [amdgpu]
C23; ? __x64_sys_ioctl+0x95/0xe0
C23; ? do_syscall_64+0x129/0x6b0
C23; ? kmem_cache_free+0x179/0x4c0
C23; ? lockdep_hardirqs_on_prepare+0xd7/0x180
C23; ? trace_hardirqs_on_prepare+0xdc/0x100
C23; ? do_syscall_64+0x238/0x6b0
C23; ? trace_hardirqs_off+0x4e/0xf0
C23; ? exit_to_user_mode_loop+0xf8/0x460
C23; ? trace_hardirqs_on_prepare+0xdc/0x100
C23; ? do_syscall_64+0x238/0x6b0
C23; ? vfs_writev+0x9a/0x490
C23; ? find_held_lock+0x2b/0x80
C23; ? __fget_files+0xbf/0x190
C23; ? lock_release+0xd3/0x2f0
C23; ? do_writev+0xf4/0x110
C23; ? trace_hardirqs_on_prepare+0xdc/0x100
C23; ? do_syscall_64+0x238/0x6b0
C23; ? flush_tlb_func+0x74/0x340
C23; ? do_writev+0xf4/0x110
C23; ? trace_hardirqs_on_prepare+0xdc/0x100
C23; ? do_syscall_64+0x238/0x6b0
C23; ? trace_hardirqs_on_prepare+0xdc/0x100
C23; ? lockdep_hardirqs_on_prepare+0xd7/0x180
C23; ? irqentry_exit+0xbd/0x5a0
C23; ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
C23; </TASK>
C23,ncfrag=3D0/979;Modules linked in: netconsole ccm snd_seq_dummy snd_hrt=
imer snd_seq nls_ascii nls_cp437 vfat fat mt7925e mt7925_common snd_hda_co=
dec_atihdmi
joydev snd_usb_audio mt792x_lib snd_hda_codec_hdmi intel_rapl_msr mt76_con=
nac_lib snd_usbmidi_lib snd_ump intel_rapl_common mt76 snd_rawmidi iosf_mb=
i
snd_seq_device snd_hda_intel mac80211 rapl wmi_bmof snd_hda_codec snd_hda_=
core libarc4 snd_intel_dspcfg spd5118 snd_hwdep cfg80211 regmap_i2c snd_pc=
m pcspkr
snd_timer snd rfkill soundcore evdev ccp k10temp nct6775 nct6775_core hwmo=
n_vid efi_pstore configfs efivarfs autofs4 ext4 mbcache jbd2 amdgpu hid_ge=
neric usbhid
hid drm_client_lib i2c_algo_bit drm_buddy drm_ttm_helper ttm drm_exec drm_=
suballoc_helper mfd_core drm_panel_backlight_quirks gpu_sched amdxcp
drm_display_helper drm_kms_helper ahci libahci drm libata scsi_mod cec xhc=
i_pci igc scsi_common crc16 xhci_hcd nvme nvme_core video usbcore nvme_key=
ring
nvme_auth hkdf=20
C23,ncfrag=3D920/979;usb_common i2c_piix4 gpio_amdpt gpio_generic i2c_smbu=
s wmi
C23;---[ end trace 0000000000000000 ]---
C23;RIP: 0010:vfree_atomic+0x55/0x60
C23;Code: 07 48 89 c1 f0 48 0f b1 3a 75 f3 48 85 c9 74 05 c3 cc cc cc cc 4=
8 8b 35 a1 70 c1 00 48 83 c2 08 bf 20 00 00 00 e9 cb 29 d6 ff <0f> 0b 66 0=
f 1f 84 00
00 00 00 00 f3 0f 1e fa 41 56 41 54 55 53 48
C23;RSP: 0018:ffffb949cd76b5f8 EFLAGS: 00010286
C23;RAX: 0000000000ff0000 RBX: ffffb949cdfd5000 RCX: 0000000000000183
C23;RDX: 0000000000ff0000 RSI: 000000000000003d RDI: ffffb949e08ad000
C23;RBP: ffff98058f900000 R08: 0000000000000000 R09: ffffffffc11e6d50
C23;R10: 0000000000000006 R11: ffff9804480c8ad0 R12: ffff980448140000
C23;R13: ffff980423000000 R14: 0000000000000001 R15: ffff980566daa000
C23;FS:  00007f93c3e6fb80(0000) GS:ffff9813a0a46000(0000) knlGS:0000000000=
000000
C23;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
C23;CR2: 00007ff941d9d000 CR3: 000000011261e000 CR4: 0000000000f50ef0
C23;PKRU: 55555554
C23;Kernel panic - not syncing: Fatal exception in interrupt
C23;Kernel Offset: 0x1a800000 from 0xffffffff81000000 (relocation range: 0=
xffffffff80000000-0xffffffffbfffffff)
C23;---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

This BUG_ON() is triggered:

void vfree_atomic(const void *addr)
{
	struct vfree_deferred *p =3D raw_cpu_ptr(&vfree_deferred);

	BUG_ON(in_nmi());

Bert Karwatzki
