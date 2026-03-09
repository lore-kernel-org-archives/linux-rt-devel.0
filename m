Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A48238B7AE
	for <linux-rt-devel@lists.linux.dev>; Mon,  9 Mar 2026 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773050636; cv=pass; b=rSyK8ZpjphT3TYTg4DxHWhW2mp1x0eVK+E/a9gBGexeLx4zvvCcz9jCnd7QGPa6Q4OFRDd8L9oJ5uR9NxVPc8uVkaSn3jF/X9jmV/7Tjjeb0AvmBvyh97m8+LViauBUxntRDffLtWzpDNxLk6mSBOH8p6R6PtrRUOzQxp8/RPb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773050636; c=relaxed/simple;
	bh=o3jaNkGDYBQTzgUWXmPXPeMrbrWzb0oNlGozzYke79U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KyAznF86yEdEQx1DPGUQHyR+Zj51wSdnSmdUopeFXkUZTY0GTj2gP+4di3yiV2Y4BzypQ39pzDjklWNRDqu2IllXoT52CYcoFaxgAndh+7VoMzdyUVCYnS5lcaOw/xHwf9DK+v16VaKiAVk0Qc32z2y89VsoEO0zX3aCBAVDx8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bJjyuGhr; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bJjyuGhr"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cd830404c2so115570885a.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 09 Mar 2026 03:03:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773050633; cv=none;
        d=google.com; s=arc-20240605;
        b=bfqvOZB6Er3pZBmtP+S+iqCbZM8K9fGQEjQqd/dJQoc7Kx8KOZxt4yGud/0JisSE8x
         FP6e4nYUcKcM6DnGJnyF8QElOLxnpCQywzfOS3sQ7PN+yNmBtsaHI4MVQaVUOvJ0zUcN
         seM7hg0kRmgWvccQrH4ccdeQdHLkGIC6sSecf+18B5ajwoOoDHMIzSnSboP/nmnJ1Jhw
         nbFXwQwySqtqwB3eylWAhTNjQFSUIk5rsGC4hf/NxSAeCSLfsGXFVgsPqv9mgbTGoRA9
         gK5DFH3bc42KekkJu/Va9eL9OU7x0MB5eBCzO1qYO6MADwsn3G5j5CtIZML8LUTBfjv3
         3/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xSfqXtScotu5XTRky9yvHGfmaaQCdm2/cA82kCXoKvk=;
        fh=Ps0X57c0RqxJ/EzHCUjPOR26nQ14vUnHahGzBxUNkN4=;
        b=ST9Dz2hsF0MFoWpCGZiKy1lAnxxA6zK/Bf0ui0EAmQnVw7rpwMUL8uakP/8s155pOE
         mgEymgx2XAGBfsPdz0GzuYaYa51rr6xLH3XlJ/shL9mBFzXqC63JidgKXVOAv5vg/9Hg
         oNTGrSQbQkhPUobDp6kkVNgZm2XIhyshn9aHTgXyNdgJ+g/PQkMv1prETfUN7TI2ERIw
         Q67bF3lsNxwM4GipRxGJ1fEyyrbGbwNR1RVTNwQkMxmcYYebSWfzeDiEW0xW1TW5EAKB
         UL7Wp7Em3n1FdAYY6lyeqJFZZ9Gjl3ai9hJOr9+pQLuACRKsW5YH8pTEyvxjXZVaMvZo
         UjQg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773050633; x=1773655433; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSfqXtScotu5XTRky9yvHGfmaaQCdm2/cA82kCXoKvk=;
        b=bJjyuGhr2tm8CObwdTzsz/7vFnvHMxTENc250D/0vFxSI0wcMzqCvu6MfIsjowcMyX
         z2ol2cdyUPpE1IGwYmvT7JhthkLPmdT3XTk9Rq38ztFfc6zBpWRtcu3cYtN4lzab3STN
         AXjok9A/gPnpLo6GancXiJrum4d4nRgvBmbyVMU8Z6+Gj4BS9yYmdUMcLsD+Ddqsm3F1
         BYtuGFvDXcK5u8m+hotGrhUYdGQNz7exA25VknXvurQAAEfUHNdxlCJotuecY6deCe5k
         cG8yzwhsllAlt1p/80TVf4eFd5zwj7uZP+e2owdL+DJ6sSI6d3rlXQQdZiqUvU0r8S1j
         +TnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773050633; x=1773655433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xSfqXtScotu5XTRky9yvHGfmaaQCdm2/cA82kCXoKvk=;
        b=Do+Xf2ygu+HCIEXMnmCxrXGA4X6iXeXohkCOQY3S6Nvty9Cx2m5GTpqtj4J8oIdvZg
         8ABGdVM0MJZvY5nlEUFy1195dNKataasShAaYUqsaiQi31wrLOYcavZEdruvSD8WIVsK
         dM5BGg3Dnvw9YEr0UzLUurHk64G6xP0/wRL7UhB0LMD5e3rApznmAvAurpwgc5WMPuSg
         JARRiVGpbi3df1xGUO8BYRUEf64QemW/AjnRPjwhcC97tuM5vG0+D7u4HAW35pq2kokz
         0Z+fFX3R2x8555wdebnYSAnPAnktiC3kkxB2IRRf8lnPxOmmM9EilDXvxiPPTB3fRl+n
         Tcmw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ3d7m34fOqfYHHeZLYS4wdWkYqa05mScoTxiolviIhAWnK6a3ZmhlyiPOSWGdiprakAPP9aB+61SqJ4/I7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwaXEKZEsn8vCZPWJCx2cU6VqsNFRr3GFwYqOhUKd16VRXXm6VT
	7UB0LTW+GV+j/Fy5wOFbrj3AZi2E0h5kiVYbbuP9hIiwhPKjkCxSFJ3YnCBQfXo3axAq0MLWsB6
	/Ia12rR28L2VK6TopsswhrmJlNbtKGJI9UqViqwLg
X-Gm-Gg: ATEYQzxsQWKkzyuNmN3XGesCZSffr3pTdaH1w3ZjjW65ef7LahqBYr9ccyS+GPJ0jQX
	FRBdUSXVGsPfUT6WrMD/NuePYMQvPln3WjcC19AoZGgwiPdsoj5yn4a55JbDkygNjXIWRs+Fy+z
	qoxmp+5ZL1beFXECnYqNmcOxhP54Bhl8W1lTCvCeiCrhUvT0E9jad72jM//JD4gpBYmadYiM0rR
	PZ8rJelayKWKGyCA0/vbE8pDOSoT6AsrLfSVIRrxbvYOPtitgrQ6RuRWulvkBdDS/q55QuDqv/t
	fxJ8BKg=
X-Received: by 2002:a05:620a:1726:b0:8c6:ed3d:be60 with SMTP id
 af79cd13be357-8cd6d4a14ccmr1309367085a.71.1773050632954; Mon, 09 Mar 2026
 03:03:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260309030702.128520-1-jiayuan.chen@linux.dev>
 <CANn89i+SCJmUuQo2pSVv_4YhjvXGvnGDH_HNo2XY6KxDX1Kcgg@mail.gmail.com> <903543b24e6e124ff970340e265185af176880f6@linux.dev>
In-Reply-To: <903543b24e6e124ff970340e265185af176880f6@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Mar 2026 11:03:41 +0100
X-Gm-Features: AaiRm51p8jwAE1iwbL1pN91qOyZJ3zxRXnsqElk9iOsk_BoOPc9YpeO-w-VwnW8
Message-ID: <CANn89i+k2i85Yn6gd_AxJtLD48XoZo366OGu1sLNRiU8ExOjmA@mail.gmail.com>
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

On Mon, Mar 9, 2026 at 10:41=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> March 9, 2026 at 15:46, "Eric Dumazet" <edumazet@google.com mailto:edumaz=
et@google.com?to=3D%22Eric%20Dumazet%22%20%3Cedumazet%40google.com%3E > wro=
te:
>
>
> >
> > On Mon, Mar 9, 2026 at 4:07 AM Jiayuan Chen <jiayuan.chen@linux.dev> wr=
ote:
> >
> > >
> > > syzkaller reported a kernel panic [1] with the following crash stack:
> > >
> > >  Call Trace:
> > >  BUG: unable to handle page fault for address: ffff8ebd08580000
> > >  PF: supervisor write access in kernel mode
> > >  PF: error_code(0x0002) - not-present page
> > >  PGD 11f201067 P4D 11f201067 PUD 0
> > >  Oops: Oops: 0002 [#1] SMP PTI
> > >  CPU: 2 UID: 0 PID: 451 Comm: test_progs Not tainted 6.19.0+ #161 PRE=
EMPT_RT
> > >  RIP: 0010:bond_rr_gen_slave_id+0x90/0xd0
> > >  RSP: 0018:ffffd3f4815f3448 EFLAGS: 00010246
> > >  RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffff8ebc8728b17e
> > >  RDX: 0000000000000000 RSI: ffffd3f4815f3538 RDI: ffff8ebc8abcce40
> > >  RBP: ffffd3f4815f3460 R08: 0000000000000000 R09: 0000000000000000
> > >  R10: 0000000000000000 R11: 0000000000000000 R12: ffffd3f4815f3538
> > >  R13: ffff8ebc8abcce40 R14: ffff8ebc8728b17f R15: ffff8ebc8728b170
> > >  CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >  CR2: ffff8ebd08580000 CR3: 000000010a808006 CR4: 0000000000770ef0
> > >  PKRU: 55555554
> > >  Call Trace:
> > >  <TASK>
> > >  bond_xdp_get_xmit_slave+0xc0/0x240
> > >  xdp_master_redirect+0x74/0xc0
> > >  bpf_prog_run_generic_xdp+0x2f2/0x3f0
> > >  do_xdp_generic+0x1fd/0x3d0
> > >  __netif_receive_skb_core.constprop.0+0x30d/0x1220
> > >  __netif_receive_skb_list_core+0xfc/0x250
> > >  netif_receive_skb_list_internal+0x20c/0x3d0
> > >  ? eth_type_trans+0x137/0x160
> > >  netif_receive_skb_list+0x25/0x140
> > >  xdp_test_run_batch.constprop.0+0x65b/0x6e0
> > >  bpf_test_run_xdp_live+0x1ec/0x3b0
> > >  bpf_prog_test_run_xdp+0x49d/0x6e0
> > >  __sys_bpf+0x446/0x27b0
> > >  __x64_sys_bpf+0x1a/0x30
> > >  x64_sys_call+0x146c/0x26e0
> > >  do_syscall_64+0xd3/0x1510
> > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >
> > Please, can you always provide symbols in such traces ?
> > You can use scripts/decode_stacktrace.sh to make the trace really
> > nice, instead of ugly.
> >
>
>
> Hi Eric,
>
> Thank you for the suggestion. I didn't include the fully decoded stack
> trace in the cover letter because the syzkaller report already contains
> the complete information. You can find it here if needed:
>
> https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D15448952580000
> https://syzkaller.appspot.com/bug?extid=3D80e046b8da2820b6ba73

Exactly.

Either copy the syzbot stack traces when they have the symbols,
or do not copy them if they don't have them, a link to them is just good en=
ough.
