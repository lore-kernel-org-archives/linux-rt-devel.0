Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714052701BB
	for <linux-rt-devel@lists.linux.dev>; Tue, 16 Dec 2025 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765879850; cv=none; b=DbSbviGSduw8RdDrvszBI2K1pcosku38pVhGLa5DfEMfnimWi2l/JoTRQbJ839kGih5F/WeQ5BYW/uZ8mDeGxee4e9vKmTYlRRUcEocv7YWSQncesiaBrew/jmlGA4W6A3B0owzcP2LjA6BgiTokKTwC9JHanvpXjUd7fwJ0rHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765879850; c=relaxed/simple;
	bh=t5rEzB0XfV2HhggtoY+1nXODslnee9LcIT7edg43TyE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I9leAeLT/oSMad/wvgLTXk6t6t1V4AMlMJBnSyv4kw6pic6OXgMo4ZrXHc+bWiSBS43U4tOw7CaEyDAK7ceb/arzswmpT1B/1W8AXikZeliJ5j/KOmRWcYMFQGN6xBx7bqW7HARx1d/3Kl9/8osuqJT5b6Q/P36BNfSN/8HB+BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZY2Jgba7; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZY2Jgba7"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4779981523fso41474115e9.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 16 Dec 2025 02:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765879847; x=1766484647; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5rEzB0XfV2HhggtoY+1nXODslnee9LcIT7edg43TyE=;
        b=ZY2Jgba7cddfwQyfdxk2CUv0rKXlbyNnoDNVhHD/C5s4s1YQn0razuQh22sBDjcttk
         gf185pGSxHoGXE0tQMb45/PzFg0dit/6ehd+lYweZ1MrFTygMMEa7TlHOoEZ2k0XfdTQ
         4CabEtL3tmUID01n5GhpVPEmuhsio7nMKB+TYKEdu9fmw/FmfDNoV5QokwbxZEJjncsb
         KIQOl1CVpCd4FM6mW7DgLtgTEP1R9HxeKasJfvNGKtYxUNhIKpNcuxMOacK+GalDGb6Q
         YkxlScUUWD22bBwgBdDKMlnzrIrpt96ZcaP3c0a5NEqaqsg3ARP9jYMRgxI6nIoDcJRM
         RUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765879847; x=1766484647;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t5rEzB0XfV2HhggtoY+1nXODslnee9LcIT7edg43TyE=;
        b=wcGRcifhkzgfBm/LQMpojAsXpy53d17ia07gs393zwy60ToUZElvPqb3wiI1GyIkNX
         Tz0/a2vQ0F9v6Cs1xha41XeJz4Xc57LfzGc05HxOkq9YsOVEDOoN1CT3NtLSBcJKRZ5k
         ic5/8i2wjdu3p/OKxuTJQEhwftUrt6J+P75qge/XSbtdDedFNQUasMY47o/u80F1lLvF
         B9XUiiGjMINg43XSJxml+af8xifqizGzGMEjwh2yzYoEdEXSATkaFt27BA1lRhH6xcBm
         nAA7I2ptFr4dt6MBVSeI4+eOADu3k/aS34sRW2WzlAMSrrYxDvyTI6ZsnKmSkZ3bxxou
         ehMg==
X-Forwarded-Encrypted: i=1; AJvYcCXuAC8xSr+fDzuC/TA22IuS0ol95oJu85Y79VKssfz4AoQgkZuqDu07K8riW2kCLQryS3D7gO0EH81bWdx2sg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/e81LhQOJ3D7qEuhA/r9ps7d1sWJzyAzR6fCw2nr567eMT2zE
	ncI9xp3Hunwac+FNl9Q9WYsl/GCaZJ9F1O3t+D0UeH1pPmoYKwwUitILshhFhXyORwSx6iNTE9+
	ndeF5kZfbdaX4hQ==
X-Google-Smtp-Source: AGHT+IEd1DtqS9iGujKBf5Wl3HxnREueKAOxGRaJlybjiAz1XyBUCEjyQ5pN21ilTcLVd3HJFgAC3/iwKoa2lQ==
X-Received: from wmbd22.prod.google.com ([2002:a05:600c:58d6:b0:477:632b:1238])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3104:b0:479:3a86:dc1a with SMTP id 5b1f17b1804b1-47a8f9155fcmr137796355e9.36.1765879846765;
 Tue, 16 Dec 2025 02:10:46 -0800 (PST)
Date: Tue, 16 Dec 2025 10:10:46 +0000
In-Reply-To: <aT/drjN1BkvyAGoi@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251212161832.2067134-1-yeoreum.yun@arm.com> <20251212161832.2067134-3-yeoreum.yun@arm.com>
 <CA+i-1C2e7QNTy5u=HF7tLsLXLq4xYbMTCbNjWGAxHz4uwgR05g@mail.gmail.com>
 <aT5/y3cSGIzi2K+m@e129823.arm.com> <DEYOI8H2OESD.1H56D3H8HKILB@google.com>
 <aT/WOAr4osoJWaMS@e129823.arm.com> <DEYP7JSVTB9D.3EFN2KEHH3O79@google.com> <aT/drjN1BkvyAGoi@e129823.arm.com>
X-Mailer: aerc 0.21.0
Message-ID: <DEZK5U2YP6I0.27VJHSVK14646@google.com>
Subject: Re: [PATCH 2/2] arm64: mmu: use pagetable_alloc_nolock() while stop_machine()
From: Brendan Jackman <jackmanb@google.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>, Brendan Jackman <jackmanb@google.com>
Cc: <akpm@linux-foundation.org>, <david@kernel.org>, 
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>, 
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>, <ast@kernel.org>, 
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>, 
	<eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>, 
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>, 
	<haoluo@google.com>, <jolsa@kernel.org>, <hannes@cmpxchg.org>, 
	<ziy@nvidia.com>, <bigeasy@linutronix.de>, <clrkwllms@kernel.org>, 
	<rostedt@goodmis.org>, <catalin.marinas@arm.com>, <will@kernel.org>, 
	<ryan.roberts@arm.com>, <kevin.brodsky@arm.com>, <dev.jain@arm.com>, 
	<yang@os.amperecomputing.com>, <linux-mm@kvack.org>, 
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, 
	<linux-rt-devel@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon Dec 15, 2025 at 10:06 AM UTC, Yeoreum Yun wrote:
[snip]
>> Overall I am feeling a bit uncomfortable about this use of _nolock, but
>> I am also feeling pretty ignorant about PREEMPT_RT and also about this
>> arm64 code, so I am hesitant to suggest alternatives, I hope someone
>> else can offer some input here...
>
> I understand. However, as I mentioned earlier,
> my main intention was to hear opinions specifically about memory contenti=
on.
>
> That said, if there is no memory contention,
> I don=E2=80=99t think using the _nolock API is necessarily a bad approach=
.


> In fact, I believe a bigger issue is that, under PREEMPT_RT,
> code that uses the regular memory allocation APIs may give users the fals=
e impression
> that those APIs are =E2=80=9Csafe to use,=E2=80=9D even though they are n=
ot.

Yeah, I share this concern. I would bet I have written code that's
broken under PREEMPT_RT (luckily only in Google's kernel fork). The
comment for GFP_ATOMIC says:

 * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lo=
wer
 * watermark is applied to allow access to "atomic reserves".
 * The current implementation doesn't support NMI and few other strict
 * non-preemptive contexts (e.g. raw_spin_lock). The same applies to %GFP_N=
OWAIT.

It kinda sounds like it's supposed to be OK to use GFP_ATOMIC in a
normal preempt_disable() context. So do you know exactly why it's
invalid to use it in this stop_machine() context here? Maybe we need to
update this comment. Or, maybe actually we need to fix the allocator so
that GFP_ATOMIC allocs are safe in this context?
