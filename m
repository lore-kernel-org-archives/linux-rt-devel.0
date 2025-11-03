Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C6630DD37
	for <linux-rt-devel@lists.linux.dev>; Mon,  3 Nov 2025 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173424; cv=none; b=el16Lc4u5sk0TWTD/MfUWnecWPDSScvc6Ledw1ggMatqtqLHQzyikz1aTkVwIsMLvPIgWJaDlvPNW1ZnU2XAMIoZmIz1Ryo2+RCJzKtReJSMElFveWyXKno/DE6wcDn9lE5Un9qJYSjg0Iyy6j5EVU/wmDpOlfpu9eAD0uoTJKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173424; c=relaxed/simple;
	bh=smdHe0JYAP2HWyeONT3qxz8zEigaBGb/6kd/i2rrOtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOAJtvL3pWtUM+mrN1bYFH0AtxkALl9zOdS3z2CcrTolMDF0+2qQHhTlDQFYgpQn7Fptr6RW8inoU7+FBctD9ecfZ6nQ/5SBpgrbEZnVX5YC7hXt3Vnd5HyooH0xKtXpU9hxElT3PbhcoAHhjFsFJKsblhUqIrCoAlzMYreQ+PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u5x3LfNV; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u5x3LfNV"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4e88ed3a132so55185911cf.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 03 Nov 2025 04:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762173417; x=1762778217; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJpmLQaGLkUNyR2mIrudPXYFCLuJyEQvKY5bubb3HvU=;
        b=u5x3LfNVRrasP7LpllCLexJXTP7jmmoJOAU1Df48ESF51SAUwsQGOl4X/ndSzWg0MT
         M1ZbJw3fHrSyvprSUf9Thn1jd5Y7TwCtl68/Rp28F2cHSvTPD32HvZAfpy0fkzHl/YZX
         GcjmasiDc6oZFQwkCpynhFp5+yiucNAZGTeOMahuLwm7rssAogLfJ3MWfDCQwlZ97UwQ
         /vOTy+Tz9WUSse2hXHWbGHvHucdgpMhTfbKeJut8vmJUjvjueHAtAO9QPLomF3RiAxD/
         73xCiiuJM1YSYKcLCs1GkmI1Bk/TrxPfsbkL34N/XANrX6nDK2GelUfY+tebxPcxnqqz
         a+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762173417; x=1762778217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJpmLQaGLkUNyR2mIrudPXYFCLuJyEQvKY5bubb3HvU=;
        b=t77mGhicopwHJnjQuZzVZpYFSEsB4h8SW97jKrKodmI+3SiiTllLxHKlKexXMCsZiE
         ynnwZSyYBesM1hDluwIJ8dDGNkC6AR5NFMChvhsKAz0C+po7Zgw0LV4ffgftd85RBcxa
         6OgZ+UvL3+fFEqu4YtchMLLabZFu31rpARnefFHlCNL/BtBHl0e3KlqXvChCyUFtkqsA
         nN1J8yShhKYxW8MLS+E88aOBbgoNkQzQVpH+0m2vv1i9OKgc6oz0G0A9y6h7FbK94N0P
         AAn6B9pJ64dDFMh+LfEQmWwLzjB2X6pmfJeTPleC9oO2oWYuzD4fZF3xAJdlUl6QshlY
         T0dg==
X-Forwarded-Encrypted: i=1; AJvYcCUZq1XxckRIao94qb2xfLEGfRhkTZSHws55eoNjz6ZVnRrBvXf5th58BEyQAz03XwFd44cZxqMswPRZfFxeEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxK0Y2khksw2lM0mG/kQWxyyZg+N9sh8TyDwnNfCVDAFpAzXqRF
	O1nLY3cStID2sjSMr7aMftWRyzT46hx8ql55ZAcdIsL4us819P8WpEg87U5jq6FtVfbYFRCVf9N
	lykWdcDjzm2tSQV8Jye598K6O5pPuCDu2aXwX63WE
X-Gm-Gg: ASbGnctU7Hy8PI1C1YaDusftRUrW9LWAQYCPFjH6zR28/ZL6CJqxQI3TFlTphAGwq38
	s3Y0KQcIFJFZB+OqkyX0Yvb9cmfEcJsqtIR1kXTdpMX4vCXUP/Nhf15NEfCbC+clWbQ0e1sOdo3
	PCVhsO29IOijOSAE+n6gYEK1dCaNn/bTBOnVZOzxnuiKTsVzsVyyqfejBeh43HJBhzxe5XmAnwh
	kE3+OCOaiQSDfieyv6P/zUILcG2HPup9Ceev9RBBcDV5EjQ2dN2x666ENh3sNssSh9xlw==
X-Google-Smtp-Source: AGHT+IGJDWfGI+mhpfWLwsg2815JXBHbpcJXt4OW1xKGQ0uKWLdy6Za63sXWRdpvhyKpmkFocaItJ2CcgAKtlV1HwB4=
X-Received: by 2002:a05:622a:181c:b0:4ed:1455:f420 with SMTP id
 d75a77b69052e-4ed217b7492mr223819281cf.2.1762173416336; Mon, 03 Nov 2025
 04:36:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251009094338.j1jyKfjR@linutronix.de> <66664116-edb8-48dc-ad72-d5223696dd19@nvidia.com>
In-Reply-To: <66664116-edb8-48dc-ad72-d5223696dd19@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 3 Nov 2025 04:36:45 -0800
X-Gm-Features: AWmQ_blKr0eQKaCT_WZntZq0h7QCNtp92cGSCX6DkbXwf8EvE8hh8reMInJNo2Y
Message-ID: <CANn89iKvgROcpdCJu726x=jCYNnXLwW=1RN5XR0Q_kbON15zng@mail.gmail.com>
Subject: Re: [PATCH net] net: gro_cells: Use nested-BH locking for gro_cell
To: Gal Pressman <gal@nvidia.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	syzbot+8715dd783e9b0bef43b1@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 4:20=E2=80=AFAM Gal Pressman <gal@nvidia.com> wrote:
>
> On 09/10/2025 12:43, Sebastian Andrzej Siewior wrote:
> > The gro_cell data structure is per-CPU variable and relies on disabled
> > BH for its locking. Without per-CPU locking in local_bh_disable() on
> > PREEMPT_RT this data structure requires explicit locking.
> >
> > Add a local_lock_t to the data structure and use
> > local_lock_nested_bh() for locking. This change adds only lockdep
> > coverage and does not alter the functional behaviour for !PREEMPT_RT.
> >
> > Reported-by: syzbot+8715dd783e9b0bef43b1@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/68c6c3b1.050a0220.2ff435.0382.GAE@g=
oogle.com/
> > Fixes: 3253cb49cbad ("softirq: Allow to drop the softirq-BKL lock on PR=
EEMPT_RT")
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> Hello Sebastian,
>
> This patch results in the following lockdep warning [1] when running
> IPsec + vxlan tests, can you please take a look?
>
> If needed, you can see the test here [2], though it might be a bit
> outdated.
>
> FWIW, Eric's patch [3] did not solve this issue.
>
> [1]
>
>  [ 6953.101639] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  [ 6953.103703] WARNING: possible recursive locking detected
>  [ 6953.105293] 6.18.0-rc3_for_upstream_debug_2025_10_30_15_01 #1 Not tai=
nted
>  [ 6953.107235] --------------------------------------------
>  [ 6953.108814] swapper/0/0 is trying to acquire lock:
>  [ 6953.109926] ffffe8ffff8234b0 (&cell->bh_lock){+.-.}-{3:3}, at: gro_ce=
lls_receive+0x3a2/0x8e0
>  [ 6953.110756]
>  [ 6953.110756] but task is already holding lock:
>  [ 6953.111377] ffff8884d3a52700 (&cell->bh_lock){+.-.}-{3:3}, at: gro_ce=
ll_poll+0x86/0x560
>  [ 6953.112163]
>  [ 6953.112163] other info that might help us debug this:
>  [ 6953.112831]  Possible unsafe locking scenario:
>  [ 6953.112831]
>  [ 6953.113460]        CPU0
>  [ 6953.113768]        ----
>  [ 6953.114075]   lock(&cell->bh_lock);
>  [ 6953.114468]   lock(&cell->bh_lock);
>  [ 6953.114854]
>  [ 6953.114854]  *** DEADLOCK ***
>  [ 6953.114854]
>  [ 6953.115529]  May be due to missing lock nesting notation
>  [ 6953.115529]
>  [ 6953.116233] 5 locks held by swapper/0/0:
>  [ 6953.116652]  #0: ffff8884d3a52700 (&cell->bh_lock){+.-.}-{3:3}, at: g=
ro_cell_poll+0x86/0x560
>  [ 6953.117606]  #1: ffffffff8506b9a0 (rcu_read_lock){....}-{1:3}, at: ne=
tif_receive_skb_list_internal+0x309/0xfa0
>  [ 6953.119051]  #2: ffffffff8506b9a0 (rcu_read_lock){....}-{1:3}, at: ip=
_local_deliver_finish+0x2dc/0x5e0
>  [ 6953.120345]  #3: ffffffff8506b9a0 (rcu_read_lock){....}-{1:3}, at: vx=
lan_rcv+0xa94/0x4180 [vxlan]
>  [ 6953.121737]  #4: ffffffff8506b9a0 (rcu_read_lock){....}-{1:3}, at: gr=
o_cells_receive+0x4a/0x8e0
>  [ 6953.123062]
>  [ 6953.123062] stack backtrace:
>  [ 6953.123603] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.18.0-r=
c3_for_upstream_debug_2025_10_30_15_01 #1 NONE
>  [ 6953.123609] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS =
rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>  [ 6953.123614] Call Trace:
>  [ 6953.123619]  <IRQ>
>  [ 6953.123621]  dump_stack_lvl+0x69/0xa0
>  [ 6953.123628]  print_deadlock_bug.cold+0xbd/0xca
>  [ 6953.123633]  __lock_acquire+0x168b/0x2f60
>  [ 6953.123640]  lock_acquire+0x10e/0x300
>  [ 6953.123643]  ? gro_cells_receive+0x3a2/0x8e0
>  [ 6953.123647]  ? lock_acquire+0x10e/0x300
>  [ 6953.123651]  ? vxlan_rcv+0xa94/0x4180 [vxlan]
>  [ 6953.123663]  gro_cells_receive+0x3ab/0x8e0
>  [ 6953.123667]  ? gro_cells_receive+0x3a2/0x8e0
>  [ 6953.123671]  vxlan_rcv+0xbb7/0x4180 [vxlan]
>  [ 6953.123683]  ? encap_bypass_if_local+0x1e0/0x1e0 [vxlan]
>  [ 6953.123692]  ? nf_conntrack_double_lock+0xc3/0xd0
>  [ 6953.123698]  ? udp_queue_rcv_one_skb+0xa41/0x1420
>  [ 6953.123702]  udp_queue_rcv_one_skb+0xa41/0x1420
>  [ 6953.123706]  ? __udp_enqueue_schedule_skb+0x1160/0x1160
>  [ 6953.123711]  udp_unicast_rcv_skb+0x106/0x330
>  [ 6953.123714]  __udp4_lib_rcv+0xe55/0x3160
>  [ 6953.123720]  ? udp_sk_rx_dst_set+0x70/0x70
>  [ 6953.123723]  ? lock_acquire+0x10e/0x300
>  [ 6953.123727]  ip_protocol_deliver_rcu+0x7e/0x330
>  [ 6953.123732]  ip_local_deliver_finish+0x39d/0x5e0
>  [ 6953.123736]  ip_local_deliver+0x156/0x1a0
>  [ 6953.123740]  ip_sublist_rcv_finish+0x8f/0x260
>  [ 6953.123744]  ip_list_rcv_finish+0x45f/0x6a0
>  [ 6953.123749]  ? ip_rcv_finish+0x250/0x250
>  [ 6953.123752]  ? ip_rcv_finish_core+0x1fb0/0x1fb0
>  [ 6953.123756]  ? ip_rcv_core+0x5d8/0xcc0
>  [ 6953.123760]  ip_list_rcv+0x2dc/0x3f0
>  [ 6953.123765]  ? ip_rcv+0xa0/0xa0
>  [ 6953.123768]  ? __lock_acquire+0x834/0x2f60
>  [ 6953.123772]  __netif_receive_skb_list_core+0x479/0x880
>  [ 6953.123777]  ? __netif_receive_skb_core.constprop.0+0x42a0/0x42a0
>  [ 6953.123780]  ? lock_acquire+0x10e/0x300
>  [ 6953.123784]  netif_receive_skb_list_internal+0x671/0xfa0
>  [ 6953.123788]  ? inet_gro_receive+0x737/0xdb0
>  [ 6953.123791]  ? process_backlog+0x1310/0x1310
>  [ 6953.123794]  ? find_held_lock+0x2b/0x80
>  [ 6953.123796]  ? dev_gro_receive+0x11ad/0x3320
>  [ 6953.123799]  ? dev_gro_receive+0x11ad/0x3320
>  [ 6953.123802]  ? dev_gro_receive+0x21c/0x3320
>  [ 6953.123806]  napi_complete_done+0x1a3/0x7b0
>  [ 6953.123809]  ? netif_receive_skb_list+0x380/0x380
>  [ 6953.123813]  gro_cell_poll+0x23a/0x560
>  [ 6953.123818]  __napi_poll.constprop.0+0x9d/0x4e0
>  [ 6953.123821]  net_rx_action+0x489/0xdf0
>  [ 6953.123826]  ? __napi_poll.constprop.0+0x4e0/0x4e0
>  [ 6953.123828]  ? do_raw_spin_trylock+0x150/0x180
>  [ 6953.123832]  ? do_raw_spin_lock+0x129/0x260
>  [ 6953.123835]  ? __rwlock_init+0x150/0x150
>  [ 6953.123840]  handle_softirqs+0x192/0x810
>  [ 6953.123846]  irq_exit_rcu+0x106/0x190
>  [ 6953.123849]  common_interrupt+0x90/0xb0
>  [ 6953.123855]  </IRQ>
>  [ 6953.123856]  <TASK>
>  [ 6953.123858]  asm_common_interrupt+0x22/0x40
>  [ 6953.123861] RIP: 0010:pv_native_safe_halt+0x13/0x20
>  [ 6953.123867] Code: 33 00 00 00 48 2b 05 b4 aa 94 00 c3 cc cc cc cc cc =
cc cc cc cc cc cc 8b 05 ea 5a 74 02 85 c0 7e 07 0f 00 2d df bf 0e 00 fb f4 =
<c3> cc cc cc cc cc cc cc cc cc cc cc cc 41 54 55 53 48 89 fb 48 83
>  [ 6953.123870] RSP: 0018:ffffffff84e07e08 EFLAGS: 00000246
>  [ 6953.123874] RAX: 0000000000000000 RBX: ffffffff84e2f540 RCX: ffffffff=
83d92d2c
>  [ 6953.123876] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff=
817cf030
>  [ 6953.123878] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed10=
9a7484fa
>  [ 6953.123880] R10: ffff8884d3a427d3 R11: 0000000000000000 R12: fffffbff=
f09c5ea8
>  [ 6953.123882] R13: ffffffff85a954a0 R14: 1ffffffff09c0fc7 R15: 00000000=
00000000
>  [ 6953.123885]  ? ct_kernel_exit.constprop.0+0xac/0xd0
>  [ 6953.123889]  ? do_idle+0x300/0x3d0
>  [ 6953.123894]  default_idle+0x5/0x10
>  [ 6953.123897]  default_idle_call+0x66/0xa0
>  [ 6953.123899]  do_idle+0x300/0x3d0
>  [ 6953.123903]  ? arch_cpu_idle_exit+0x30/0x30
>  [ 6953.123906]  ? __schedule+0xdcc/0x3180
>  [ 6953.123910]  ? do_idle+0x18/0x3d0
>  [ 6953.123913]  cpu_startup_entry+0x50/0x60
>  [ 6953.123917]  rest_init+0x20a/0x210
>  [ 6953.123920]  start_kernel+0x3aa/0x3b0
>  [ 6953.123924]  x86_64_start_reservations+0x20/0x20
>  [ 6953.123928]  x86_64_start_kernel+0x11d/0x120
>  [ 6953.123932]  common_startup_64+0x129/0x138
>  [ 6953.123939]  </TASK>
>
> [2] https://github.com/Mellanox/ovs-tests/blob/master/ipsec-tests/test-ip=
sec-crypto-vxlan.sh
> [3] https://lore.kernel.org/netdev/20251020161114.1891141-1-edumazet@goog=
le.com/

Adding LOCKDEP annotations would be needed (like what we do in
netdev_lockdep_set_classes()

Or I would try something like :

diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
index fd57b845de333ff0e397eeb95aa67926d4e4a730..2cac53439f62addbd8562a66b28=
bf01bdbddf02c
100644
--- a/net/core/gro_cells.c
+++ b/net/core/gro_cells.c
@@ -60,9 +60,11 @@ static int gro_cell_poll(struct napi_struct *napi,
int budget)
        struct sk_buff *skb;
        int work_done =3D 0;

-       __local_lock_nested_bh(&cell->bh_lock);
        while (work_done < budget) {
+               __local_lock_nested_bh(&cell->bh_lock);
                skb =3D __skb_dequeue(&cell->napi_skbs);
+               __local_unlock_nested_bh(&cell->bh_lock);
+
                if (!skb)
                        break;
                napi_gro_receive(napi, skb);
@@ -71,7 +73,6 @@ static int gro_cell_poll(struct napi_struct *napi, int bu=
dget)

        if (work_done < budget)
                napi_complete_done(napi, work_done);
-       __local_unlock_nested_bh(&cell->bh_lock);
        return work_done;
 }
