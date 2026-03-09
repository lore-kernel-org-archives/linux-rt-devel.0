Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4347536A02E
	for <linux-rt-devel@lists.linux.dev>; Mon,  9 Mar 2026 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773042398; cv=pass; b=bMrHCerx9B72PZ2deCfGBFwHnqU4PT+nPwsaHY3S/qvtZJ+bFAF1y9x022UXrRRaEHXgC5sg6TzOz2A0MeekPjI4c4VomVIH18zXExNyA4d9Evh4i9V81Cgouu4+PhQLD6OmKLdg4txb19xReuRq0RGZnJLRmQIFKXn8u2Jt7gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773042398; c=relaxed/simple;
	bh=eacRXzXf/aiA5OgRGa3k7SPsaozGRTTdOpU1VEE4zBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3lbbkKuhqXwdXKVxEujedPo/+XtHSzqucopTaD2MuzFVSVat8RDmGfo2Uswc4Oe3rYXDOL4b0gZUc52HE9cU76V6hc50WFlCAtd4aVTzsLdn9L5+ehc1UXFyh4oh89z/E5uz/GBO/ViR2e2Oia48oE2xrALbOzz27eujm6JIKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zSIRh4v0; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zSIRh4v0"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89a1d7cc7f0so42167396d6.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 09 Mar 2026 00:46:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773042396; cv=none;
        d=google.com; s=arc-20240605;
        b=ECx02THbYcfNjLP0SqeFKNjrgfbpyReSTNTWGN10UBC+gBAaXKCxIXcvwP251PaX+W
         Xpsmwi9eh88Utt+IwuJ5AiFPogGpnzBufJilxMMECAZxTraHKWXs0/YBMsl/5T6oJILf
         NtsUzaLXiFNvaS4hK02x6KCQt1aspmT9Jf3LQByZqP7Rhw0Qrfq9cdbU1brDjx+u6JL/
         c/r6qksCLfbFYGmTxryBKxSNZANy+7wtVnUFF1DlUVTGUYZU/io4cuaCDlHHdQK0vCld
         7fGv/wy6GJsZWSxyAgfzOAKu9o4K0fmwKiBXlSqFqwD5hZODPvtEmPtlsj8qzRvWY154
         dYhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dy2wEMRvx8pDR1Qm7aqueQadBuYC5mw6ZCVKfgZ4OGs=;
        fh=4jcNprZG5VONBOq0dhlCsS9LajgePs2ppUOta65T4wo=;
        b=LcOYzTHSMlSa6sb0kba9+jWoBCQdZluRLDS7vAdQmAW4MCEpjbfFwvc4ds+4JJAFOH
         D6gk9VqmEJBbqdlgfg5Zxx8gnFVxOypeVleEZjAq3hEyh20Vv20E5WvwafYJupT344Wj
         pGbIY7VXvOfglGWW9pNVYLPhh9Vh0e8LTMeTiPW5L4lTK8SkHPVflhA9+D2/D1WK8QJ0
         gZniQEEPtmU3mYWwl7zw8V/A7UhiNL29ACa9mL7AJJXekaryEqhLYj9vGt+WaFi7AjZ2
         nb6mF2HBvSfy0TBEW/jiKLkxo/+LvXAsYyo8IKt4ryze0kf8w0rLLxtYLgD2NVqu9P4/
         GCZA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773042396; x=1773647196; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dy2wEMRvx8pDR1Qm7aqueQadBuYC5mw6ZCVKfgZ4OGs=;
        b=zSIRh4v0zaOJZ97yHLdxCVhIEgPbWZqCWtoOgDq6uYQKzxyXHjEPCPncXel1LXnVpf
         hRAvdsGjMYgK8fZW+Pt9VHSl1bTMr7DNUBQFd85p5xJCKhyiMf48U89N2LgzN4h1kIQx
         Oj7GgBgs10smlypQ2Bhszf2JDeESPDkC54rrxSWO9H1dy/K5Q4zE3/WGTHet8icEhSxL
         03xD/Vxx8ry8+bXIDDs44oTQfzQ3/DZ50HwbKPqojier8snoHfnvIiSOn/0hzeAwunrA
         Z4CHP4YhP8KInYl0LHjvlHtSp/+28rtIapfNO6yghOQpzB8FNbeAH8e0dvFg2fgKDfdr
         cmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773042396; x=1773647196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dy2wEMRvx8pDR1Qm7aqueQadBuYC5mw6ZCVKfgZ4OGs=;
        b=rrp9AVKewA4AvA/ez8ILRWTIypY6zYJ9lKsAlpB1Oyy3ZImeRABYaBmaYbQlDjagAP
         UR87l/UnxYAtOa7jbuIzKHmg64xHfiTKWTnHKx9jowGiknYz+g6s6dlhLLhGyWrNRN0R
         GPJhSrJli0bZJX/XmxeoStyOrJt/5z8bC4dcbLz8W9jFIbGNWO5G+HVZoZIn01pS00nV
         uw/m1sfGApxzLxspgagmGss1ioyMxgG8Fr8tusO6E24uTcGCLaGgmxNQsnHzNsm/It10
         IR519HcZoNSOM6ccTES7feet46+SvUWjXCtSeK/K0+u2xAqWUzoz4ciJZFTtr7Wy9xzp
         MJoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7id5JUhaMA8yB82jyvjO2PihTIPBdVjKxcVnQRY5HpzoojZEyo8fp/GXKOHIW/VnpAH67GaDNEfT3T+BRRA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywv/kKfPd/fyaQGE6UGuplPx7t+vtaDB99Mon10C/935l2KnIVI
	bM9g3CS2AN9BiAI7zckNZcETWcrBgqFceLwjSTeZ/G3MjpWcsa5SsMYZU62ybE0/LweFg9+7ZGq
	G7tmuq24REV6EyUWmO2aF2wYVeT/Cfd4oQSrOsfc/
X-Gm-Gg: ATEYQzzVXEk/CIC0UnZEiES2VMSZvgl2BDIixsvDKrv8AQ8DKld+8RfrQkWQkIhU+yL
	fZtexjWueyldScyS/cCTJxdsXcap8y5EkrJ8wfNq4bwJxu1AOfifOQa6F0tTGz18HtWDvgBOY9/
	nYWkqmLOTZUIrSM52wZsfEaRqjKkoBHBsAepLJwg9ZrD5BQIu5N4eza9Ep7ZcPB1jzDqsla23KB
	d45YLF7mqFi6/UtFGrGPFL/HGX8/ZPuuZZ/UsJ3vQoiJRdxscHC17GCJsJlWPz6kGEGY6GuqC5B
	ADFeIJ4=
X-Received: by 2002:a05:6214:f0e:b0:899:f691:fd3a with SMTP id
 6a1803df08f44-89a30a5ac53mr155765816d6.27.1773042395649; Mon, 09 Mar 2026
 00:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260309030702.128520-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260309030702.128520-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Mar 2026 08:46:24 +0100
X-Gm-Features: AaiRm51LwOtGnsLFGw5-TXI1ygOjcbArZhKBv2Arly_DVU4Sw2FiUsW3cGuVy-o
Message-ID: <CANn89i+SCJmUuQo2pSVv_4YhjvXGvnGDH_HNo2XY6KxDX1Kcgg@mail.gmail.com>
Subject: Re: [PATCH net v5 0/2] net,bpf: fix null-ptr-deref in
 xdp_master_redirect() for bonding and add selftest
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, razor@blackwall.org, jiayuan.chen@shopee.com, 
	Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Jussi Maki <joamaki@gmail.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 4:07=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> syzkaller reported a kernel panic [1] with the following crash stack:
>
> Call Trace:
> BUG: unable to handle page fault for address: ffff8ebd08580000
> PF: supervisor write access in kernel mode
> PF: error_code(0x0002) - not-present page
> PGD 11f201067 P4D 11f201067 PUD 0
> Oops: Oops: 0002 [#1] SMP PTI
> CPU: 2 UID: 0 PID: 451 Comm: test_progs Not tainted 6.19.0+ #161 PREEMPT_=
RT
> RIP: 0010:bond_rr_gen_slave_id+0x90/0xd0
> RSP: 0018:ffffd3f4815f3448 EFLAGS: 00010246
> RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffff8ebc8728b17e
> RDX: 0000000000000000 RSI: ffffd3f4815f3538 RDI: ffff8ebc8abcce40
> RBP: ffffd3f4815f3460 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffffd3f4815f3538
> R13: ffff8ebc8abcce40 R14: ffff8ebc8728b17f R15: ffff8ebc8728b170
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff8ebd08580000 CR3: 000000010a808006 CR4: 0000000000770ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  bond_xdp_get_xmit_slave+0xc0/0x240
>  xdp_master_redirect+0x74/0xc0
>  bpf_prog_run_generic_xdp+0x2f2/0x3f0
>  do_xdp_generic+0x1fd/0x3d0
>  __netif_receive_skb_core.constprop.0+0x30d/0x1220
>  __netif_receive_skb_list_core+0xfc/0x250
>  netif_receive_skb_list_internal+0x20c/0x3d0
>  ? eth_type_trans+0x137/0x160
>  netif_receive_skb_list+0x25/0x140
>  xdp_test_run_batch.constprop.0+0x65b/0x6e0
>  bpf_test_run_xdp_live+0x1ec/0x3b0
>  bpf_prog_test_run_xdp+0x49d/0x6e0
>  __sys_bpf+0x446/0x27b0
>  __x64_sys_bpf+0x1a/0x30
>  x64_sys_call+0x146c/0x26e0
>  do_syscall_64+0xd3/0x1510
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Please, can you always provide symbols in such traces ?
You can use scripts/decode_stacktrace.sh to make the trace really
nice, instead of ugly.

>
> Problem Description
>
> bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NULL
> check. rr_tx_counter is a per-CPU counter only allocated in bond_open()
> when the bond mode is round-robin. If the bond device was never brought
> up, rr_tx_counter remains NULL.
>
> The XDP redirect path can reach this code even when the bond is not up:
> bpf_master_redirect_enabled_key is a global static key, so when any bond
> device has native XDP attached, the XDP_TX -> xdp_master_redirect()
> interception is enabled for all bond slaves system-wide.
>
> Solution
>
> Patch 1: Add a NULL check with unlikely() in bond_rr_gen_slave_id() befor=
e
> dereferencing rr_tx_counter. When rr_tx_counter is NULL (bond was never
> opened), fall back to get_random_u32() for slave selection. The existing
> allocation in bond_open() is kept, with WRITE_ONCE() added to pair with
> the READ_ONCE() in the NULL check.
> Patch 2: Add a selftest that reproduces the above scenario.
>
> Changes since v4:
> https://lore.kernel.org/netdev/20260304074301.35482-1-jiayuan.chen@linux.=
dev/
> - Reverted unconditional alloc in bond_init(); instead add a NULL check
>   with unlikely()/READ_ONCE() in bond_rr_gen_slave_id() and WRITE_ONCE()
>   in bond_open(), avoiding memory waste for non-RR modes
>   (Suggested by Nikolay Aleksandrov, patch by Jay Vosburgh)
>
> Changes since v3:
> https://lore.kernel.org/netdev/20260228021918.141002-1-jiayuan.chen@linux=
.dev/T/#t
> - Added code comment and commit log explaining why rr_tx_counter is
>   allocated unconditionally for all modes (Suggested by Jay Vosburgh)
>
> Changes since v2:
> https://lore.kernel.org/netdev/20260227092254.272603-1-jiayuan.chen@linux=
.dev/T/#t
> - Moved allocation from bond_create_init() helper into bond_init()
>   (ndo_init), which is the natural single point covering both creation
>   paths and also handles post-creation mode changes to round-robin
>
> Changes since v1:
> https://lore.kernel.org/netdev/20260224112545.37888-1-jiayuan.chen@linux.=
dev/T/#t
> - Moved the guard for NULL rr_tx_counter from xdp_master_redirect()
>   into the bonding subsystem itself
>   (Suggested by Sebastian Andrzej Siewior <bigeasy@linutronix.de>)
>
> [1] https://syzkaller.appspot.com/bug?extid=3D80e046b8da2820b6ba73
>
> Jiayuan Chen (2):
>   bonding: fix null-ptr-deref in bond_rr_gen_slave_id()
>   selftests/bpf: add test for xdp_master_redirect with bond not up
>
>  drivers/net/bonding/bond_main.c               |   9 +-
>  .../selftests/bpf/prog_tests/xdp_bonding.c    | 101 +++++++++++++++++-
>  2 files changed, 106 insertions(+), 4 deletions(-)
>
> --
> 2.43.0
>
