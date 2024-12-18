Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE68D14F9E2
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Dec 2024 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734511103; cv=none; b=MDHmXs8wXcMl2fMnBDTjpQnpnnJbgHKfbQVd62ZT2RsTbeOkPJMN6ujTPYhFWiHA0xhtNu/BGpjsc32Hj8J5C7wgb4Viuq1irHMvMOliV5ZNIoFouW+Xfnir9u6Fhnl12H4Js6SlnKuEKZ7I6bYpLNRjSYv3+82ewhM33wsqTjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734511103; c=relaxed/simple;
	bh=sOz1hPr2Av5XXNgHQPrQfeqUuZFLyTUJh4m7NRNjQ6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJMlxo0zSHArJV/wpe5FGBODU7wy6uhh8EVXPFiGbRvjx1ccepQn6M6tEv3b0soTatRwvfL0rlP3SZHVWcDeIGnAUFrlwJh2ObmN8dcbSlzy5JJ5FuajYjkS4JqZWM6Qt3XUdnC+JGIWQSEKQiy6ISSX2ZWtRJa3GtTtj+cd7nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XK6gYthq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XK6gYthq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734511099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXhZeUFK6b+cNEJmj0OqH76u6rSs98YqB0iwpOfkRQA=;
	b=XK6gYthqAJkzVKCIrMY2jbTMUkkgWoFrKlIIwCoQoE5JJ19KfMDAlBYCbaS+Goo1eesC5L
	O79xySt6icL64FgAaPG+DNNnQD2aHQWSSY8wz/spnt6rtTNXtBGaeped3s40+W3FK/0PQv
	nmBfyjwDr5lvW2RtIyGq008DjBIrRhA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-MJ5u6DUuPgKP4jScRwfJuA-1; Wed, 18 Dec 2024 03:38:18 -0500
X-MC-Unique: MJ5u6DUuPgKP4jScRwfJuA-1
X-Mimecast-MFC-AGG-ID: MJ5u6DUuPgKP4jScRwfJuA
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2f2a9743093so3734415a91.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 18 Dec 2024 00:38:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734511097; x=1735115897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXhZeUFK6b+cNEJmj0OqH76u6rSs98YqB0iwpOfkRQA=;
        b=XOXhinUC+Otl3Ir/WLhGw/CQM688MMBzIJ0etfLuvAUF1tytj5gXBffasLKsSvu0dD
         KDWJZpq4lMnGFRSefvcy4fUjA/XWUzgwSVzXg6tEwfWMPBw3RTANz6Zy10m11uOcjFXb
         svTaurN0dH0nImMtCQb2HrHXFILrP3N1pFe5nn1qonnsPQ+m/3j9GqwjAbKT39eosNOI
         WtMXoxr+kK40OZQUKC4SjVH/k8e/jawT+vyrTLgg+BKmzYFLaUj0Xc8lTj/c3sDgmzkt
         beMlx0062RxbEMcDfnl0/bq0Oc1pv1twA5c76CAt3plMgHAg8Wu6Nq6DO4huaWfy+RBj
         Nvew==
X-Forwarded-Encrypted: i=1; AJvYcCWQwLNeWeUgUADRQWS6OMpXRpdNyILxyFGYZBQ1VM52uhVdSVdgrBgyqIpsK9QyvfxgryjcppPxwYFwkm4wpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxccvqVLj47jwHv+j4nEKEx/6TsDADAX2VvnzTffT65K8f3Xbop
	mUSuitGcvbhTJqreKnS3DrT4nUpDE+COfUtuHIHecb69DhfBt5kB1GfrhkAYqnsq/cdW+Md1uhv
	Eo1+hQxmnAhyECdjp0sVVmnUBm8g3cOKfx0cmOTE383Ysh4rhuC63AcWowrDytiHw2anL90FgLZ
	iEWmOhq7qTMX2eC3d1j+T0c+h+Q3mXuAicO9OPmNw=
X-Gm-Gg: ASbGnct842V6hRvPn39BqiM3V54YUNEjbbxJCmzPQD8I88isDRhmJzT63v8615C5TiZ
	V0zhnbp3plM0MT9Jov4EoVLpcCcWDC0EzDXyK
X-Received: by 2002:a17:90a:d88c:b0:2ee:b6c5:1def with SMTP id 98e67ed59e1d1-2f2e91a9f37mr3013704a91.8.1734511097494;
        Wed, 18 Dec 2024 00:38:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERJ+rCyFaCK9KWdPjeSfugeNQbClj+M3YtT1FmXeAPS6uU9onXzRO23fVdJD39RhVX7aosUaYaDbwRn9x+h8M=
X-Received: by 2002:a17:90a:d88c:b0:2ee:b6c5:1def with SMTP id
 98e67ed59e1d1-2f2e91a9f37mr3013687a91.8.1734511097206; Wed, 18 Dec 2024
 00:38:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241217142032.55793-1-acarmina@redhat.com> <20241217095504.ea2a3a24564af4df48cf0b19@linux-foundation.org>
In-Reply-To: <20241217095504.ea2a3a24564af4df48cf0b19@linux-foundation.org>
From: Alessandro Carminati <acarmina@redhat.com>
Date: Wed, 18 Dec 2024 09:38:05 +0100
Message-ID: <CAGegRW7qRpPLWJ7Q_j-J1fsKfxvv6+m_8N5q9QVZL6jgUz9cqw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/kmemleak: Fix sleeping function called from invalid
 context at print message
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, 
	Alessandro Carminati <alessandro.carminati@gmail.com>, 
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, 
	Gabriele Paoloni <gpaoloni@redhat.com>, Eric Chanudet <echanude@redhat.com>, clement.leger@bootlin.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EZlwxsBAtEZllFenjS6a26KDXYS37pWxRnZGX96eQM0_1734511097
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Andrew,
Thanks for the feedback.

On Tue, Dec 17, 2024 at 6:55=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 17 Dec 2024 14:20:33 +0000 Alessandro Carminati <acarmina@redhat.=
com> wrote:
>
> > Address a bug in the kernel that triggers a "sleeping function called f=
rom
> > invalid context" warning when /sys/kernel/debug/kmemleak is printed und=
er
> > specific conditions:
> > - CONFIG_PREEMPT_RT=3Dy
> > - Set SELinux as the LSM for the system
> > - Set kptr_restrict to 1
> > - kmemleak buffer contains at least one item
> >
> > BUG: sleeping function called from invalid context at kernel/locking/sp=
inlock_rt.c:48
> > in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 136, name: cat
>
> -rt is a bit annoying this way.  Things which we expect to work OK are
> no longer doing so.
>
> > preempt_count: 1, expected: 0
> > RCU nest depth: 2, expected: 2
> > 6 locks held by cat/136:
> >  #0: ffff32e64bcbf950 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb8/0x=
e30
> >  #1: ffffafe6aaa9dea0 (scan_mutex){+.+.}-{3:3}, at: kmemleak_seq_start+=
0x34/0x128
> >  #3: ffff32e6546b1cd0 (&object->lock){....}-{2:2}, at: kmemleak_seq_sho=
w+0x3c/0x1e0
> >  #4: ffffafe6aa8d8560 (rcu_read_lock){....}-{1:2}, at: has_ns_capabilit=
y_noaudit+0x8/0x1b0
> >  #5: ffffafe6aabbc0f8 (notif_lock){+.+.}-{2:2}, at: avc_compute_av+0xc4=
/0x3d0
> > irq event stamp: 136660
> > hardirqs last  enabled at (136659): [<ffffafe6a80fd7a0>] _raw_spin_unlo=
ck_irqrestore+0xa8/0xd8
> > hardirqs last disabled at (136660): [<ffffafe6a80fd85c>] _raw_spin_lock=
_irqsave+0x8c/0xb0
> > softirqs last  enabled at (0): [<ffffafe6a5d50b28>] copy_process+0x11d8=
/0x3df8
> > softirqs last disabled at (0): [<0000000000000000>] 0x0
> > Preemption disabled at:
> > [<ffffafe6a6598a4c>] kmemleak_seq_show+0x3c/0x1e0
> > CPU: 1 UID: 0 PID: 136 Comm: cat Tainted: G            E      6.11.0-rt=
7+ #34
> > Tainted: [E]=3DUNSIGNED_MODULE
> > Hardware name: linux,dummy-virt (DT)
> > Call trace:
> >  dump_backtrace+0xa0/0x128
> >  show_stack+0x1c/0x30
> >  dump_stack_lvl+0xe8/0x198
> >  dump_stack+0x18/0x20
> >  rt_spin_lock+0x8c/0x1a8
> >  avc_perm_nonode+0xa0/0x150
> >  cred_has_capability.isra.0+0x118/0x218
> >  selinux_capable+0x50/0x80
> >  security_capable+0x7c/0xd0
> >  has_ns_capability_noaudit+0x94/0x1b0
> >  has_capability_noaudit+0x20/0x30
> >  restricted_pointer+0x21c/0x4b0
> >  pointer+0x298/0x760
> >  vsnprintf+0x330/0xf70
> >  seq_printf+0x178/0x218
> >  print_unreferenced+0x1a4/0x2d0
> >  kmemleak_seq_show+0xd0/0x1e0
> >  seq_read_iter+0x354/0xe30
> >  seq_read+0x250/0x378
> >  full_proxy_read+0xd8/0x148
> >  vfs_read+0x190/0x918
> >  ksys_read+0xf0/0x1e0
> >  __arm64_sys_read+0x70/0xa8
> >  invoke_syscall.constprop.0+0xd4/0x1d8
> >  el0_svc+0x50/0x158
> >  el0t_64_sync+0x17c/0x180
> >
> > %pS and %pK, in the same back trace line, are redundant, and %pS can vo=
id
> > %pK service in certain contexts.
> >
> > %pS alone already provides the necessary information, and if it cannot
> > resolve the symbol, it falls back to printing the raw address voiding
> > the original intent behind the %pK.
> >
> > Additionally, %pK requires a privilege check CAP_SYSLOG enforced throug=
h
> > the LSM, which can trigger a "sleeping function called from invalid
> > context" warning under RT_PREEMPT kernels when the check occurs in an
> > atomic context. This issue may also affect other LSMs.
> >
> > This change avoids the unnecessary privilege check and resolves the
> > sleeping function warning without any loss of information.
> >
> > Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
>
> I'm adding
>
> Fixes: 3a6f33d86baa ("mm/kmemleak: use %pK to display kernel pointers in =
backtrace")
> Cc: <stable@vger.kernel.org>
>
> > --- a/mm/kmemleak.c
> > +++ b/mm/kmemleak.c
> > @@ -373,7 +373,7 @@ static void print_unreferenced(struct seq_file *seq=
,
> >
> >       for (i =3D 0; i < nr_entries; i++) {
> >               void *ptr =3D (void *)entries[i];
> > -             warn_or_seq_printf(seq, "    [<%pK>] %pS\n", ptr, ptr);
> > +             warn_or_seq_printf(seq, "    %pS\n", ptr);
> >       }
> >  }
>
> Before 3a6f33d86baa we were still printing the address, with plain old
> %p.  Should we restore that, or is %p always useless?
>

The intent of 3a6f33d86baa8 is to make pointers available for debugging
purposes.
My argument for this change is that %pS provides already sufficient
information for debugging purposes.

We essentially have two scenarios concerning %pS:
1. When the symbol can be resolved by kallsyms: In this case, a
   symbol+offset style pointer is emitted, which I find more useful than
   just the address.
2. When the symbol cannot be resolved by kallsyms: Here, the raw pointer
   is emitted. This undermines the original intent of %pK, as both the
   masked address and the plain address are exposed.

If we want to be picky, there's an additional factor to consider: KASLR.
%pS emits its output accounting for randomization, but in most cases, the
randomized offset information is lost.
The exception is when the symbol cannot be resolved by kallsyms, though
this should be rare. It's still worth mentioning.

Back to your question: %p emits an hashed address that is not
reversible by design.
Therefore, in my opinion, it is not particularly useful in a debug
message.

--=20
---
172

