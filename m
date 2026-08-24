Received: from mail-ej2-f0.google.com (mail-ej2-f0.google.com [74.125.228.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA20421223
	for <linux-rt-devel@lists.linux.dev>; Mon, 24 Aug 2026 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577122; cv=none; b=OqXm8JkwwJNSSNrvn0j1DXdikwTYQESiyQNiEDDTOsPkbxxK5jhSPcB2OaHvlRHPYbVs9fkwusgYUIG8t5bDg0oKWl75GiP1RF/TW0oAttedo241dj5OlWFEVynZuyqh7KcG6ZUMLyD4Bsd7YZcCXWiiS7MvZFu0jJer/DfVHRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577122; c=relaxed/simple;
	bh=UoDDENVMVF5Bz2fZwHd0lFydgvPhiZFqNxWecRPzuk0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ksmtZqw7XxU8YkkpZsXEa1W8aNLFvu/PsAm0UWICD11lusZQURkNgw2bpEVf3jcb6OPh6JdBQVdFe6HQg0Y9/bXtS0zVEM6rejrAbfu1oAJroqBJgVsG5Ai96/1jgZwaaP3xcAcPykURukY765KByQ5b14T2mYjj628dKAOHcgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l91YM0hC; arc=none smtp.client-ip=74.125.228.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l91YM0hC"
Received: by mail-ej2-f0.google.com with SMTP id a640c23a62f3a-c16772d888aso164679466b.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 24 Aug 2026 06:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787577119; x=1788181919; darn=lists.linux.dev;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UoDDENVMVF5Bz2fZwHd0lFydgvPhiZFqNxWecRPzuk0=;
        b=l91YM0hCzvsX6UI+Uo3HyKF6HgFDFyojAKrrL44FFB0J0MNmHXoDCZVDJlxg2XC5lk
         +XYLBdwb1k4nBsc5LhBRfNh/p+pkGSsfqwWpeccZBvhZZbO//u/sI3QwT6yQUHkXLtC3
         qAQAsWLHPdladBp/VhF7jVSzfdfmfokCPz+qNzwQe7QQj9wgLnJgcAcThcTxuCzKDAym
         4pkvSgrawYcNWrDms6mywc6dyBPCPwOA6B7Mc2cWiQEGLOEZYtLHhfAJwK3Y75+IES1D
         iopY038bS103idylnk8TF9nWNwbPwU3vA7cyfcq1s6BQLbjRdRCNAdqrGc8NIPaACntN
         C29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787577119; x=1788181919;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UoDDENVMVF5Bz2fZwHd0lFydgvPhiZFqNxWecRPzuk0=;
        b=c+9XFut+AeJzK+FMrnxRivvaCaAHp7eDaEorofebW4MsV3b8TWPqz+vB1Zmfr1IPOX
         Vl9lNkweSGrupeg/qVqfJOCEbDKh/gkOddx10fl8t7ym4b5FDfLUeBZwJ56OSHDx7KNu
         wGRhWcd+yqNNNkUx05r4w+ijS3P5EZrB9or4rYEKf8I2CVbRGEgt5x4oaHYytNLqejbV
         R72wB9U1wg5vf4FJ1Bc9ZyRWfkjGFfr6BkXnNYhbB4RWZrZJM3NbyKeg0u4vWNjuMWcb
         CTdoVJGhFZ13baV/LG4j+fRLeu7jfECTUL8gj1DD+AxDTXH6QZsIchgWuoxzixVl1SL/
         epwg==
X-Forwarded-Encrypted: i=1; AHgh+RrD0RwUPqw0mvG8E0PFAj0TwSh/wrw3vm2ZyyeaW9fiwPd7EW5p7dfKFmqwahaboNS4hvHF2CiZfCaHtqaXlA==@lists.linux.dev
X-Gm-Message-State: AFuF++k7Yd2LuLrQCt5hdEpZ+7fegFNA5LbOxc4zFnxKzCozK/kUOYtB
	PRNTnbM5YBPD5rp24zl25GcLd0IYXxYPifeB7D7NT6IMu/HcxX7R0i8b
X-Gm-Gg: AR+sD10OONz71bX10pJf7Uh7m0O23LgcQvUxYg0FPwLwak0hU8AMdjWRRUVNWNe2w+Z
	7g6JA6VbIvaDF9oQerdzuDaFQc5md84hjfGCP2X/Yw5BYRCiwy/Vva/ySP7cPn328CPcNZqb+NZ
	uaZ8qXTVkLfqTGbqbk9zoD0t8o+VFaOdvGBWfjh3YAOThPSSu2PDaizRT4ApUXv9gzYP+7sceuB
	qyVquN9OZ1UNkvhynVgW+Hvou1kwL1gEQ0Rrsjdt2r3wVyCw4ktUWLeTCEIgS2HsQSFON1Uu8Hr
	1vR3/FRaGUBWsLMJCq+ktPbSQigq5rE+u6u0M8oOcdW202yXXw9BbKKbZdF9S3IVbizv1Ki7Z3u
	LJfw+IpbWKt6NbniZMGqdrej41vuKf7hx4rigJd/mUba/fI2wzAwwHFWkk46pURk0h3/1hEUKoB
	W/r7zDQ27bijVEQvYUEszbdNkLBpkExplRV1WNjs2orDvsO5eyzAYNdlf1BjGzghFL1knzG/HQ6
	EFSICoAzxeiFCRJXz8J8yjQ5C0GnE+JKQFUU4Vpsjnj3Ppwq71m3w97vQHKTurUM7xXp38BX2ot
	rVeq2dmZB9wgRMNjYoOO6GWq+bE=
X-Received: by 2002:a17:907:3d42:b0:c12:6632:e7f0 with SMTP id a640c23a62f3a-c2492797eb0mr2083634066b.24.1787577118741;
        Mon, 24 Aug 2026 06:11:58 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496295627sm1207740566b.15.2026.08.24.06.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 06:11:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 15:11:57 +0200
Message-Id: <DKX77B18XF28.LG3DX8NUFQGI@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Michal Hocko" <mhocko@suse.com>, "Jiayuan Chen"
 <jiayuan.chen@linux.dev>
Cc: <bpf@vger.kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "John Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Martin KaFai
 Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Add a sleepable page allocator for
 map memory
X-Mailer: aerc 0.21.0
References: <20260821050250.35112-1-jiayuan.chen@linux.dev>
 <20260821050631.39784-1-jiayuan.chen@linux.dev>
 <aow4YNCDa0gDwbfj@tiehlicka>
 <de12ff1b-2f7c-4efe-ba1f-95e0b8d259f2@linux.dev>
 <aoxAo6gDK00PeCzG@tiehlicka>
In-Reply-To: <aoxAo6gDK00PeCzG@tiehlicka>

On Mon Aug 24, 2026 at 3:01 PM CEST, Michal Hocko wrote:
> On Mon 24-08-26 20:44:18, Jiayuan Chen wrote:
>>
>> On 8/24/26 8:26 PM, Michal Hocko wrote:
>> > On Fri 21-08-26 13:06:12, Jiayuan Chen wrote:
>> > > bpf_map_alloc_pages() picks the allocator via can_alloc_pages(), a
>> > > conservative guess for BPF program context that is always false unde=
r
>> > > PREEMPT_RT. So even a caller that really is sleepable gets the
>> > > non-blocking allocator, which never reclaims and never engages the O=
OM
>> > > machinery.
>> > I thought one of the main motivations was reentrancy. As you cannot
>> > really assume the context bpf_map_alloc_pages is called from there is =
an
>> > extra care needed so that this doesn't re-enter the allocator from bpf
>> > program called from allocator path and deadlock.
>>
>>
>> Agreed, bpf_map_alloc_pages() is designed to be safe to run in any conte=
xt.
>>
>> The commit message should be precise.
>
> How do you achive any level of safety for the _sleepable version? Vast
> majority of the kernel is sleepable but that doesn't mean this is safe
> from the mm reentrancy POV.

I think it will only be invoked directly in the arena map fault handler, wh=
ich
runs in task context. If an interrupt occurs and tries to allocate pages,
can_alloc_pages() will return false and it should pick the _nolock() varian=
t
which is safe against reentrancy.
