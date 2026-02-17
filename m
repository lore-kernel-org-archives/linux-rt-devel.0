Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5AB2F3C10
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Feb 2026 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771318613; cv=none; b=gFOQTjqhLq0zr6CwDdTYuWyk6zSn1ulUOV0EULy5zvZ9votFxbwXbLEeTxpzl4vzCWd1hBLg2iiLt3q2nteM8KHWVkhOcLXiy6OWtqb89jMfa5dymt9sQbCe3bvX4gSFX+c+ljnKeHkYLVY2YL5rI8SzLK4wTF0TrFip93Sd9Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771318613; c=relaxed/simple;
	bh=nJnXjknClI/OvJ+maeRZMcSJtXgHxxJRWhvLCc0HZoU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dDLwA2fAfPx1ffiHevupmTOcZTM1heM2aGDWnR2ww43yAiUMPpQvu98/WVmTjsk+6CU2UcwdB1oyeJqFewaBoLHP6MsFUUcyPWUF7cxBlqO9iRPYeVSAjzFnj2ZZaWF+qe4VHzCoGPuSZqu471t0Gtp5D1vINeicinHicHsF5Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=lbakvFuX; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="lbakvFuX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1771318609; x=1771923409; i=spasswolf@web.de;
	bh=mpla3cPnfIqj1OoYiCzW1dG2v0S4xqxhACt4VdaEBy4=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lbakvFuXmrFQiLG6364UcdtIDaTBFJ186JbZww0FpN4XwTkpxHZRwW7z7EaMgULr
	 h5LVfPZQ2BwT4C5MsjYQHiHCSW2s0qzX5iMBdczbxXWp7s5bJZenYp5Vo3LceOG5g
	 4zv2rnHrmFhOlBO1hoycNny8v48dra30eZiNeuqJWTfElo0FbWPkGrc/nWjVytdQx
	 M2SoLMZnwEVkWgFkOvBg9J1yV2MgxORQZn73fw8CNkWslmOcUrBqptfUbduykR41u
	 sjvNG5NiCMs8ohdXCfZMf821CcIMoUhkRyTSGrYCYVeuroPNIqOCeCAUwC7IBye5+
	 L+wjcSJObiWNYuCJSQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDMv4-1w0U6B0L3O-002yjw; Tue, 17
 Feb 2026 09:56:49 +0100
Message-ID: <80114792206dc00d0099f00999a209e717debb12.camel@web.de>
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on
 PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, spasswolf@web.de
Date: Tue, 17 Feb 2026 09:56:48 +0100
In-Reply-To: <20260217071952.WCXLGs5-@linutronix.de>
References: <20260216134333.412332-1-spasswolf@web.de>
	 <6274de932f4a62c51b424b65fc875ef3cb5ffd60.camel@web.de>
	 <20260216153745.CA3__zRc@linutronix.de>
	 <37d6e27f96afb57c5716798530cb3560d25202e5.camel@web.de>
	 <20260217071952.WCXLGs5-@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VMblhIzNIaD/6YyPFGiXNkMDXamK1+lu6luk1Dsp/XQptNsy6gb
 51fIorF8B2p+GXo1ar/b9Hg2W9tbGDTRMYn3CJmk3/BrhBO7uTAVilLl27xNARwPWRUN5rt
 +CfMFhrMQXKrGW8f+su2uSMlvzIxE/CuK2rMWWxM13k6EH3RWsHVoUQARVPKVbhK/C0nfQf
 v6wbpHK8uszYauiN9BMVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Q1gxTkd2cSE=;0zoa+T5w+nhBnorATsFXuCF9xnk
 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

Am Dienstag, dem 17.02.2026 um 08:19 +0100 schrieb Sebastian Andrzej Siewi=
or:
> On 2026-02-17 00:48:25 [+0100], Bert Karwatzki wrote:
> > The problem seems to be that different preemtible threads try to send =
skbs.=20
>=20
> This does not matter because the counter is per-thread not per-CPU.=20

The "Dead loop on virtual device" messages is not printed because dev_xmit=
_recursion()
returns true, but because READ_ONCE(txq->xmit_lock_owner) =3D=3D cpu.
>=20
> > 2026-02-17T00:29:24.212231+01:00 [ T1513] Dead loop on virtual device =
wlp4s0, fix it urgently!
>=20
> Could you please do a backtrace here, for instance via WARN_ON_ONCE()
>=20
> > Bert Karwatzki
>=20
> Sebastian

Here's the backtrace:

2026-02-17T09:48:49.553225+01:00 lisa kernel: [ T1521] __dev_queue_xmit 0:=
 skb =3D ffff9ee68afd3a00 dev =3D wlp4s0
2026-02-17T09:48:49.553227+01:00 lisa kernel: [ T1521] __dev_queue_xmit 2:=
 skb =3D ffff9ee68afd3a00 dev =3D wlp4s0 txq =3D ffff9ee6820b5a00
2026-02-17T09:48:49.553229+01:00 lisa kernel: [ T1521] __dev_queue_xmit: c=
pu =3D 7 xmit_lock_owner =3D -1
2026-02-17T09:48:49.553232+01:00 lisa kernel: [ T1521] __dev_queue_xmit 3:=
 skb =3D ffff9ee68afd3a00 dev =3D wlp4s0 txq =3D ffff9ee6820b5a00
2026-02-17T09:48:49.553234+01:00 lisa kernel: [ T1521] __dev_queue_xmit 4:=
 skb =3D ffff9ee68afd3a00 dev =3D wlp4s0 txq =3D ffff9ee6820b5a00

2026-02-17T09:48:49.553235+01:00 lisa kernel: [ T1538] __dev_queue_xmit 0:=
 skb =3D ffff9ee68afd3b00 dev =3D wlp4s0
2026-02-17T09:48:49.553238+01:00 lisa kernel: [ T1538] __dev_queue_xmit 2:=
 skb =3D ffff9ee68afd3b00 dev =3D wlp4s0 txq =3D ffff9ee6820b5a00
2026-02-17T09:48:49.553241+01:00 lisa kernel: [ T1538] __dev_queue_xmit: c=
pu =3D 7 xmit_lock_owner =3D 7
2026-02-17T09:48:49.553243+01:00 lisa kernel: [ T1538] ------------[ cut h=
ere ]------------
2026-02-17T09:48:49.553245+01:00 lisa kernel: [ T1538] WARNING: CPU: 7 PID=
: 1538 at net/core/dev.c:4800 __dev_queue_xmit.cold+0x163/0x5bd
2026-02-17T09:48:49.553248+01:00 lisa kernel: [ T1538] Modules linked in: =
ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi =
snd_seq
snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_hda_codec_gene=
ric snd_hda_codec_atihdmi snd_hda_codec_hdmi snd_hda_intel btusb snd_intel=
_dspcfg
btrtl uvcvideo btintel snd_hda_codec btbcm videobuf2_vmalloc snd_acp3x_pdm=
_dma snd_soc_dmic snd_acp3x_rn btmtk videobuf2_memops snd_soc_core snd_hda=
_core uvc
videobuf2_v4l2 bluetooth snd_hwdep videodev snd_pcm_oss snd_mixer_oss snd_=
pcm snd_rn_pci_acp3x snd_acp_config videobuf2_common msi_wmi snd_soc_acpi =
ecdh_generic
ecc mc sparse_keymap wmi_bmof snd_timer snd k10temp ccp soundcore snd_pci_=
acp3x battery ac button joydev evdev amd_pmc mt7921e mt7921_common mt792x_=
lib
mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabric=
s efi_pstore configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu drm=
_client_lib
i2c_algo_bit drm_ttm_helper ttm drm_exec drm_suballoc_helper drm_buddy drm=
_panel_backlight_quirks gpu_sched xhci_pci amdxcp xhci_hcd
2026-02-17T09:48:49.553251+01:00 lisa kernel: [ T1538]  drm_display_helper=
 hid_sensor_hub hid_multitouch mfd_core hid_generic i2c_hid_acpi psmouse
drm_kms_helper usbcore nvme amd_sfh i2c_hid hid cec nvme_core serio_raw i2=
c_piix4 r8169 crc16 usb_common i2c_smbus i2c_designware_platform i2c_desig=
nware_core
2026-02-17T09:48:49.553254+01:00 lisa kernel: [ T1538] CPU: 7 UID: 122 PID=
: 1538 Comm: isc-loop-0014 Not tainted 6.18.10-deadloop-00005-g56089d3b695=
a #1153
PREEMPT_{RT,(full)}=20
2026-02-17T09:48:49.553256+01:00 lisa kernel: [ T1538] Hardware name: Micr=
o-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 1=
1/11/2024
2026-02-17T09:48:49.553258+01:00 lisa kernel: [ T1538] RIP: 0010:__dev_que=
ue_xmit.cold+0x163/0x5bd
2026-02-17T09:48:49.553261+01:00 lisa kernel: [ T1538] Code: 3d 3e 88 5a 0=
1 66 41 83 bf ca 04 00 00 08 0f 86 4d 02 00 00 4c 89 f2 48 c7 c6 80 b3 0c =
b9 48 c7 c7
b0 b3 2f b9 e8 49 43 fd ff <0f> 0b e8 72 8f 75 00 85 c0 74 0f 4c 89 f6 48 =
c7 c7 58 b4 2f b9 e8
2026-02-17T09:48:49.553262+01:00 lisa kernel: [ T1538] RSP: 0018:ffffbd650=
6d53990 EFLAGS: 00010246
2026-02-17T09:48:49.553264+01:00 lisa kernel: [ T1538] RAX: 00000000000000=
07 RBX: ffff9ee6a089c000 RCX: 0000000000000027
2026-02-17T09:48:49.553265+01:00 lisa kernel: [ T1538] RDX: 00000000000000=
00 RSI: 0000000000000001 RDI: ffff9ee95e7d6d80
2026-02-17T09:48:49.553266+01:00 lisa kernel: [ T1538] RBP: ffff9ee68afd3b=
00 R08: 0000000000000000 R09: ffffffffb9685590
2026-02-17T09:48:49.553268+01:00 lisa kernel: [ T1538] R10: ffffffffb96a42=
10 R11: 0000000000000003 R12: ffff9ee6820b5a00
2026-02-17T09:48:49.553270+01:00 lisa kernel: [ T1538] R13: 00000000000000=
07 R14: ffff9ee6a089c118 R15: ffff9ee6b455f000
2026-02-17T09:48:49.553273+01:00 lisa kernel: [ T1538] FS:  00007f3ad75ff6=
80(0000) GS:ffff9ee9a4bf3000(0000) knlGS:0000000000000000
2026-02-17T09:48:49.553275+01:00 lisa kernel: [ T1538] CS:  0010 DS: 0000 =
ES: 0000 CR0: 0000000080050033
2026-02-17T09:48:49.553277+01:00 lisa kernel: [ T1538] CR2: 00007f3d54a240=
80 CR3: 0000000102f73000 CR4: 0000000000750ef0
2026-02-17T09:48:49.553279+01:00 lisa kernel: [ T1538] PKRU: 55555554
2026-02-17T09:48:49.553282+01:00 lisa kernel: [ T1538] Call Trace:
2026-02-17T09:48:49.553284+01:00 lisa kernel: [ T1538]  <TASK>
2026-02-17T09:48:49.553285+01:00 lisa kernel: [ T1538]  ? srso_alias_retur=
n_thunk+0x5/0xfbef5
2026-02-17T09:48:49.553287+01:00 lisa kernel: [ T1538]  ? __ip_make_skb+0x=
325/0x560
2026-02-17T09:48:49.553289+01:00 lisa kernel: [ T1538]  ip_finish_output2+=
0x2c8/0x600
2026-02-17T09:48:49.553292+01:00 lisa kernel: [ T1538]  ip_local_out+0xc6/=
0xf0
2026-02-17T09:48:49.553294+01:00 lisa kernel: [ T1538]  ip_send_skb+0x14/0=
x50
2026-02-17T09:48:49.553296+01:00 lisa kernel: [ T1538]  udp_send_skb+0x181=
/0x370
2026-02-17T09:48:49.553299+01:00 lisa kernel: [ T1538]  udp_sendmsg+0x8e8/=
0xbc0
2026-02-17T09:48:49.553301+01:00 lisa kernel: [ T1538]  ? ip_frag_init+0x6=
0/0x60
2026-02-17T09:48:49.553302+01:00 lisa kernel: [ T1538]  ? srso_alias_retur=
n_thunk+0x5/0xfbef5
2026-02-17T09:48:49.553304+01:00 lisa kernel: [ T1538]  ? aa_sk_perm+0x8e/=
0x210
2026-02-17T09:48:49.553306+01:00 lisa kernel: [ T1538]  __sock_sendmsg+0x6=
0/0x80
2026-02-17T09:48:49.553308+01:00 lisa kernel: [ T1538]  ____sys_sendmsg+0x=
21d/0x2b0
2026-02-17T09:48:49.553310+01:00 lisa kernel: [ T1538]  ? import_iovec+0x1=
b/0x30
2026-02-17T09:48:49.553312+01:00 lisa kernel: [ T1538]  ? srso_alias_retur=
n_thunk+0x5/0xfbef5
2026-02-17T09:48:49.553315+01:00 lisa kernel: [ T1538]  ? copy_msghdr_from=
_user+0xe5/0x170
2026-02-17T09:48:49.553316+01:00 lisa kernel: [ T1538]  ___sys_sendmsg+0x7=
e/0xc0
2026-02-17T09:48:49.553318+01:00 lisa kernel: [ T1538]  ? srso_alias_retur=
n_thunk+0x5/0xfbef5
2026-02-17T09:48:49.553318+01:00 lisa kernel: [ T1538]  ? rt_spin_lock+0x3=
8/0x110
2026-02-17T09:48:49.553321+01:00 lisa kernel: [ T1538]  ? srso_alias_retur=
n_thunk+0x5/0xfbef5
2026-02-17T09:48:49.553323+01:00 lisa kernel: [ T1538]  ? rt_spin_lock+0x3=
8/0x110
2026-02-17T09:48:49.553325+01:00 lisa kernel: [ T1538]  ? srso_alias_retur=
n_thunk+0x5/0xfbef5
2026-02-17T09:48:49.553327+01:00 lisa kernel: [ T1538]  ? ipv4_dst_check+0=
x36/0x60
2026-02-17T09:48:49.553330+01:00 lisa kernel: [ T1538]  ? srso_alias_retur=
n_thunk+0x5/0xfbef5
2026-02-17T09:48:49.553332+01:00 lisa kernel: [ T1538]  ? ip4_datagram_rel=
ease_cb+0x45/0x1d0
2026-02-17T09:48:49.553334+01:00 lisa kernel: [ T1538]  ? rt_spin_lock+0x3=
8/0x110
2026-02-17T09:48:49.553336+01:00 lisa kernel: [ T1538]  ? get_random_u16+0=
xc6/0x1c0
2026-02-17T09:48:49.553338+01:00 lisa kernel: [ T1538]  ? srso_alias_retur=
n_thunk+0x5/0xfbef5
2026-02-17T09:48:49.553340+01:00 lisa kernel: [ T1538]  ? rt_spin_lock+0x3=
8/0x110
2026-02-17T09:48:49.553342+01:00 lisa kernel: [ T1538]  ? srso_alias_retur=
n_thunk+0x5/0xfbef5
2026-02-17T09:48:49.553344+01:00 lisa kernel: [ T1538]  ? rt_spin_unlock+0=
x5a/0xa0
2026-02-17T09:48:49.553346+01:00 lisa kernel: [ T1538]  ? srso_alias_retur=
n_thunk+0x5/0xfbef5
2026-02-17T09:48:49.553347+01:00 lisa kernel: [ T1538]  ? rt_spin_unlock+0=
x5a/0xa0
2026-02-17T09:48:49.553349+01:00 lisa kernel: [ T1538]  ? srso_alias_retur=
n_thunk+0x5/0xfbef5
2026-02-17T09:48:49.553351+01:00 lisa kernel: [ T1538]  ? __local_bh_enabl=
e_ip+0x73/0xa0
2026-02-17T09:48:49.553353+01:00 lisa kernel: [ T1538]  ? srso_alias_retur=
n_thunk+0x5/0xfbef5
2026-02-17T09:48:49.553355+01:00 lisa kernel: [ T1538]  __sys_sendmsg+0x68=
/0xc0
2026-02-17T09:48:49.553357+01:00 lisa kernel: [ T1538]  do_syscall_64+0x65=
/0x2f0
2026-02-17T09:48:49.553359+01:00 lisa kernel: [ T1538]  entry_SYSCALL_64_a=
fter_hwframe+0x55/0x5d
2026-02-17T09:48:49.553361+01:00 lisa kernel: [ T1538] RIP: 0033:0x7f3ae6d=
239ee
2026-02-17T09:48:49.553363+01:00 lisa kernel: [ T1538] Code: 08 0f 85 f5 4=
b ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 =
08 4c 8b 4c
24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 =
00 00 00 48 83 ec 08
2026-02-17T09:48:49.553365+01:00 lisa kernel: [ T1538] RSP: 002b:00007f3ad=
75fd0a8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
2026-02-17T09:48:49.553367+01:00 lisa kernel: [ T1538] RAX: ffffffffffffff=
da RBX: 00007f3ad75ff680 RCX: 00007f3ae6d239ee
2026-02-17T09:48:49.553367+01:00 lisa kernel: [ T1538] RDX: 00000000000000=
00 RSI: 00007f3ad75fd110 RDI: 0000000000000105
2026-02-17T09:48:49.553369+01:00 lisa kernel: [ T1538] RBP: 00007f3ad75fd1=
10 R08: 0000000000000000 R09: 0000000000000000
2026-02-17T09:48:49.553371+01:00 lisa kernel: [ T1538] R10: 00000000000000=
00 R11: 0000000000000246 R12: 0000000000000000
2026-02-17T09:48:49.553373+01:00 lisa kernel: [ T1538] R13: 00007f3ad75fd7=
50 R14: 00007f3ad644c8d0 R15: 00007f3ad75fd750
2026-02-17T09:48:49.553375+01:00 lisa kernel: [ T1538]  </TASK>
2026-02-17T09:48:49.553377+01:00 lisa kernel: [ T1538] ---[ end trace 0000=
000000000000 ]---
2026-02-17T09:48:49.553379+01:00 lisa kernel: [ T1538] Dead loop on virtua=
l device wlp4s0, fix it urgently!
2026-02-17T09:48:49.553380+01:00 lisa kernel: [ T1538] __dev_queue_xmit 0:=
 skb =3D ffff9ee68afd3b00 dev =3D wlp4s0
2026-02-17T09:48:49.553381+01:00 lisa kernel: [ T1538] __dev_queue_xmit 2:=
 skb =3D ffff9ee68afd3b00 dev =3D wlp4s0 txq =3D ffff9ee6820b5a00
2026-02-17T09:48:49.553383+01:00 lisa kernel: [ T1538] __dev_queue_xmit: c=
pu =3D 7 xmit_lock_owner =3D 7
2026-02-17T09:48:49.553385+01:00 lisa kernel: [ T1538] Dead loop on virtua=
l device wlp4s0, fix it urgently!

2026-02-17T09:48:49.553387+01:00 lisa kernel: [ T1521] __dev_queue_xmit 5:=
 skb =3D 0000000000000000 dev =3D wlp4s0 txq =3D ffff9ee6820b5a00

Bert Karwatzki
