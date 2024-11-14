Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63781F8187;
	Thu, 14 Nov 2024 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582470; cv=none; b=Boc8aCBTq2rguztqZH4QeQl3P5UDMd6P4G2LMOijDOZYwSMg61enPP2mef5E//dmfAUoPbkpprqBHe6sUCsoTFTddDOQsxnpiQwosXPBLa8hTyUFK9jfOHUyq0YLnSiCZFPnIqcvbuG9x8+hDJTlgNU+BGJ9rNIv90P9FqjRzbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582470; c=relaxed/simple;
	bh=OofcrezGVEU5ao0iZ9H6FT3uGNr6VLrJ6gqtSnY6rDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bIHiCW4ChXfWzaFduAIb6OMzIJFS5IO6TOEYi5DgASK6doKwWR2fIeuRnvN2g/ELPTNJHDVa9HjVzOgtw7OXuxdmAVOwnVJL7p/+Is1nBbGvIEiWjOVI6bespoJvsvDzbA3bmBn+LOD4OtTDEunQWXuZhMQDh2gUVJemjwusQLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XA2HcVc6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XA2HcVc6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E167C4CED9;
	Thu, 14 Nov 2024 11:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731582470;
	bh=OofcrezGVEU5ao0iZ9H6FT3uGNr6VLrJ6gqtSnY6rDk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XA2HcVc6FKMMG0IOhL6IHkkoUSw8jgdMiUBdI1O5NYZfCkYOALH1qqw7PTjCw8saA
	 dJhl4ePRIAQhLGuGU738gKzUTeCrQg1nVTqId2y47A4c9xGJQZiY4hG06far0wf2GL
	 /gx6ajg9m4YmezJvhuhvNTDSWPDpaS2AxXuapfvWG2e+U2WgJuKoySr8nWZGq+4Gcj
	 k73e66sFtBRjKyhYLSupU8GIx06uSsObtJ5/DDgA8ar3WbWi3YZjdSgq9Jkz7hz5Ab
	 OX/6pkCUtmZxSdOEecY8t6/ecrH87V1Vt5tL+dFo04cauGrsUnHoXCwxteD4d+kkAu
	 JETTXysHrP/gQ==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9acafdb745so94351766b.0;
        Thu, 14 Nov 2024 03:07:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjIpP6sjglIQjWXXyNtXg+JuH+tsX+KKv8B4g65ybDq4SiviYKaewiaXoxaMyE6ezOoKaGNwHsfWI3@lists.linux.dev, AJvYcCVIZ7zYsoOpiezzLSAUzmCUq6EiwbxKdRfJ2tyqBUR4E4NK+GsySc4dbqqz1NYMZnWMnGFkZgHV1QPsHMFn/w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfX72pIQzzzw2melXxHaclxlnaS3VyP70O1ZLoMnqMr+ydqu8N
	3Rvxsc7npPk+y/5X3sCsxW9Y3aYLo3I/Q9uvme96VJDmnBIjzk6jLKJ/9m4ql57ktdEyziu+Hpz
	vrySqX7W6nXP8JsHcuG0sjjyXEaw=
X-Google-Smtp-Source: AGHT+IGb42yBdA5MQOMLHfWvvDDqX7GdkwDfAGkPZuQ/dihTqhBtNFjCWuM/cFznucyrdPNhEsFD9drB4Nwo1OJ4rk4=
X-Received: by 2002:a17:907:d20:b0:a9a:7b3d:705 with SMTP id
 a640c23a62f3a-aa207818590mr274982066b.30.1731582468777; Thu, 14 Nov 2024
 03:07:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241108091545.4182229-1-chenhuacai@loongson.cn>
 <20241108091545.4182229-4-chenhuacai@loongson.cn> <20241114103111.5W5ZY0D4@linutronix.de>
In-Reply-To: <20241114103111.5W5ZY0D4@linutronix.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 14 Nov 2024 19:07:37 +0800
X-Gmail-Original-Message-ID: <CAAhV-H72YSNBGutYPOVi=S7nwLb6YOiQOFqnimAp=9D0wAJc3g@mail.gmail.com>
Message-ID: <CAAhV-H72YSNBGutYPOVi=S7nwLb6YOiQOFqnimAp=9D0wAJc3g@mail.gmail.com>
Subject: Re: [PATCH 3/3] LoongArch: Allow to enable PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-rt-devel@lists.linux.dev, Guo Ren <guoren@kernel.org>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Sebastian,

On Thu, Nov 14, 2024 at 6:31=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-11-08 17:15:45 [+0800], Huacai Chen wrote:
> > It is really time.
> >
> > LoongArch has all the required architecture related changes, that have
> > been identified over time, in order to enable PREEMPT_RT. With the rece=
nt
> > printk changes, the last known road block has been addressed.
> >
> > Allow to enable PREEMPT_RT on LoongArch.
> >
> > Below are the latency data from cyclictest on a 4-core Loongson-3A5000
> > machine, with a "make -j8" kernel building workload in the background.
> >
> > 1. PREEMPT kernel with default configuration:
> >
> > ./cyclictest -a -t -m -i200 -d0 -p99
> > policy: fifo: loadavg: 8.78 8.96 8.64 10/296 64800
> > T: 0 ( 4592) P:99 I:200 C:14838617 Min:   3 Act:    6 Avg:    8 Max:   =
 844
> > T: 1 ( 4593) P:99 I:200 C:14838765 Min:   3 Act:    9 Avg:    8 Max:   =
 909
> > T: 2 ( 4594) P:99 I:200 C:14838510 Min:   3 Act:    7 Avg:    8 Max:   =
 832
> > T: 3 ( 4595) P:99 I:200 C:14838631 Min:   3 Act:    8 Avg:    8 Max:   =
 931
> >
> > 2. PREEMPT_RT kernel with default configuration:
> >
> > ./cyclictest -a -t -m -i200 -d0 -p99
> > policy: fifo: loadavg: 10.38 10.47 10.35 9/336 77788
> > T: 0 ( 3941) P:99 I:200 C:19439626 Min:   3 Act:   12 Avg:    8 Max:   =
 227
> > T: 1 ( 3942) P:99 I:200 C:19439624 Min:   2 Act:   11 Avg:    8 Max:   =
 184
> > T: 2 ( 3943) P:99 I:200 C:19439623 Min:   3 Act:    4 Avg:    7 Max:   =
 223
> > T: 3 ( 3944) P:99 I:200 C:19439623 Min:   2 Act:   10 Avg:    7 Max:   =
 226
> >
> > 3. PREEMPT_RT kernel with tuned configuration:
> >
> > ./cyclictest -a -t -m -i200 -d0 -p99
> > policy: fifo: loadavg: 10.52 10.66 10.62 12/334 109397
> > T: 0 ( 4765) P:99 I:200 C:29335186 Min:   3 Act:    6 Avg:    8 Max:   =
  62
> > T: 1 ( 4766) P:99 I:200 C:29335185 Min:   3 Act:   10 Avg:    8 Max:   =
  52
> > T: 2 ( 4767) P:99 I:200 C:29335184 Min:   3 Act:    8 Avg:    8 Max:   =
  64
> > T: 3 ( 4768) P:99 I:200 C:29335183 Min:   3 Act:   12 Avg:    8 Max:   =
  53
> >
> > Main instruments of tuned configuration include: Disable the boot rom
> > space in BIOS for kernel, in order to avoid speculative access to low-
> > speed memory; Disable CPUFreq scaling; Disable RTC synchronization in
> > the ntpd/chronyd service.
>
> If "rom space in BIOS for kernel" is a thing you should document it
> somewhere or issue a warning at boot. I don't know what the latency
> impact is here and if this is needed at all during runtime.
I'm sorry to confuse you. This sentence should be reworded. The real
meaning is: we should disable something in BIOS configuration, the
goal is avoid kernel code's speculative access to boot rom (low speed
memory).

>
> Why is ntpd/chronyd service affecting this? Is it running at prio 99?
> Otherwise it should not be noticed.
No, ntpd/chronyd doesn't affect latency. But they may trigger RTC
synchronization every 11 minutes, and RTC synchronization affects
latency. We can keep ntpd/chronyd running but disable RTC
synchronization by configuration, this is the least aggressive method.

>
> Is lockdep complaining in any workloads?
> Is CONFIG_DEBUG_ATOMIC_SLEEP leading to any complains?
This needs more tests because I haven't enabled them.

Huacai

>
>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> Sebastian
>
