Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975EB32143E
	for <linux-rt-devel@lists.linux.dev>; Mon, 15 Dec 2025 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765792530; cv=none; b=K68XHRC37TjRxQ7jvbgkxHqHKlhmj9Nl64FHdSUkyK8FuoN1OQbX5nvjNGS5lKteNK4X0pufx6eFIM0rITWED8aSxW9Mh+ndAGJhGC9XSmTZMihxlSmSzQeSnivmAjLLC/MoFLJPlzvmIvZXkxVoOHLKp2SNZJo/cndB2ZF3O1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765792530; c=relaxed/simple;
	bh=MErqbYG3hVSovTFjSQY3qFyCwp76vQn51NyQKwSvMfE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NR7j5umq5MFOmGCGgResmFsCcZ5gF4YUxl5Tr41Lq8ZsXYQ/sdEp9FkC1pKuYZCgqYYqNplf/AhsFCdsHKhizSfa8YbrRxYr16YS2rHwZm2CGJl1KCOjw0XrwKKCM7bPPSEYs+F8Jmez2CSwogoIDMo5TfMEZjDC2ryXohsdh1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r1Di0VLN; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r1Di0VLN"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-477cf25ceccso35775145e9.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 15 Dec 2025 01:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765792527; x=1766397327; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eXmkpglOgTRlWY6ZkKkXvIK9PamZymsXtf90xHcK+6o=;
        b=r1Di0VLN+iwKqtvsxxaN5hAxSFH/LNKDju8RBZQW6fdHvzxIaro1ruqtAjrCAUwCaC
         Tf1BGw6afnu8iAonZp/yngIuxMBpRwpNxK5DXGJamqy8prlS7SBBJbemS6IBAQB4ikME
         fkzrEXhvB/WBwxM/bN27X95OX9l9GCvy9Cd9FippGniRMKg5i0OQ/yAeI6MT7OanQbdc
         GFjIPiektzg6xUb6N/dbPdYoxLNGP3opqXkS6vPP9V29Rm/9mIIGEYq8WPYDzrQZCbZr
         if7TjM7FIOxiOm2UaJFhOQvaqb4gtcnrP7ewdwczzEhEDOHCI0mYIdfp0RswfXuPps4y
         BIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765792527; x=1766397327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eXmkpglOgTRlWY6ZkKkXvIK9PamZymsXtf90xHcK+6o=;
        b=FShYBO4R9nEm9rGxIB0DZ9iOHFoVSttp2OI/TX8FB2XtD18MWLfCDhx3k67wCH2LhO
         bB/Rh8RBuhvCilmYqx8TaLvfxHKKV35otup91ksb0B5q7T0Tvwr9DOrtOrY8pPCV95PM
         uptvxtfc4qmtFwlpX2tryS9NsS7tNPCNcbwzWBm4eYBPYnoiv+YgiMj3xzYDI6scRjE2
         xOQTedxedIjpfC59u2oOIfzNwTYJWiFiKOeMlqkKfkkyV3xwTW0ZG+gWHZ9Yica5HjAI
         vwLp7BdX/A+L0GGqLPaVUSIvnRSoH6CFsR+jIDGMpb+bd0Oaqct4a6cN99FvEFyJdf00
         W2Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXPbVKQyjG+Do10NH0wuoX0w68opD/tLTuxCtw8cf/3O/LwnaqWyIEMmFs4zGnTcQKxtdk5QNaH7MaDTQM2LA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2HyRs1AzzsGSYXrsoDUpqpDeiiMv6IMPUQmZfJ1vqjnnLtoZC
	NzMZ2tWbCXLWBdtjPqar363yXvRdEkJGaxX+QH24llDVMMz32AW0mZJTJDB0JLZTeBvMJ25MsnB
	5qZIcqa8t90ICbg==
X-Google-Smtp-Source: AGHT+IGJNUQ3yCE5dAMJ9tGmUAnyfo5RpFowfQkzScccNTMlw3Eak2tuYu3AGem3xCXRYZD9qM+KN+pYSar9uQ==
X-Received: from wrp13.prod.google.com ([2002:a05:6000:41ed:b0:430:fcc8:d29e])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:40df:b0:430:f68f:ee97 with SMTP id ffacd0b85a97d-430f68ff1b5mr5631418f8f.40.1765792526655;
 Mon, 15 Dec 2025 01:55:26 -0800 (PST)
Date: Mon, 15 Dec 2025 09:55:26 +0000
In-Reply-To: <aT/WOAr4osoJWaMS@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251212161832.2067134-1-yeoreum.yun@arm.com> <20251212161832.2067134-3-yeoreum.yun@arm.com>
 <CA+i-1C2e7QNTy5u=HF7tLsLXLq4xYbMTCbNjWGAxHz4uwgR05g@mail.gmail.com>
 <aT5/y3cSGIzi2K+m@e129823.arm.com> <DEYOI8H2OESD.1H56D3H8HKILB@google.com> <aT/WOAr4osoJWaMS@e129823.arm.com>
X-Mailer: aerc 0.21.0
Message-ID: <DEYP7JSVTB9D.3EFN2KEHH3O79@google.com>
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

On Mon Dec 15, 2025 at 9:34 AM UTC, Yeoreum Yun wrote:
> Hi Brendan,
>> On Sun Dec 14, 2025 at 9:13 AM UTC, Yeoreum Yun wrote:
>> >> I don't have the context on what this code is doing so take this with
>> >> a grain of salt, but...
>> >>
>> >> The point of the _nolock alloc is to give the allocator an excuse to
>> >> fail. Panicking on that failure doesn't seem like a great idea to me?
>> >
>> > I thought first whether it changes to "static" memory area to handle
>> > this in PREEMPT_RT.
>> > But since this function is called while smp_cpus_done().
>> > So, I think it's fine since there wouldn't be a contention for
>> > memory allocation in this phase.
>>
>> Then shouldn't it use _nolock unconditionally?
>
> As you pointed out, I think it should be fine even in the !PREEMPT_RT case.
> However, in case I missed something or if my understanding is incorrect,
> I applied it only to the PREEMPT_RT case for now.

Hmm, I don't think "this code might be broken so let's cage it behind a
conditional" is a good strategy.

1. It bloats the codebase.

2. It's confusing to readers, now you have to try an understand why this
   conditional is here, which is a doomed effort. This could be
   mitigated with comments but, see point 1.

3. It expands the testing matrix. So now we have code that we aren't
   really sure is correct, AND it gets less test coverage.

Overall I am feeling a bit uncomfortable about this use of _nolock, but
I am also feeling pretty ignorant about PREEMPT_RT and also about this
arm64 code, so I am hesitant to suggest alternatives, I hope someone
else can offer some input here...
