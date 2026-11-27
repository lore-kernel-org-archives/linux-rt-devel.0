Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795774612;
	b=ebmWrWrO88mYTYaTDK+PoC/rnH4B/BK4QW5CDqSWVjdrnKc9bhGq2TklGIBWEI79MlIZ
	 2JLx4q6uGL4Dme7pVi95yYf3NCkrQOqOkgAMJaGN0xfbQhLq8dfJEB9qvM7ytJcBj4Zoe
	 36enSW9UvfT/S4iiciQkkRXAPnGW8OSHOObrgj7L9akjTuLjspp18Cn+GCKtvcVdj9Mva
	 I9RbjjBGXc4WAHNEb0VBHAGw/otKVbWseavLWGK6bc6eJOL+TPS+HAWI5uG1LFUoCek3c
	 Xz8gU4zmMo55FQXUuQOX4U3CKZvL9ywFyflakax2/zJPQBe0/ZVlk6x2cmKBt0W88qg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774612;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KPXb3DtqJNanqI7IPB3ZYAV4XR+6OEYsAvkDzB1Mb18=;
	b=as7K4ykGQKfnZC+YUOL48T2SdeLYx6rPZAHjFIrLYMtGu2u/scsX4wqKX5rK4OwxBlM6
	 tcwZMhFma04ilRo7SGC8Y0uO0SwWSvBEIOaq4LYZy/MB0K2S+Bq9A71uxeCA+LELd2ttB
	 dWfiVoqg/fUk2aplO0KRmSFj5eTL8LtFu+EMzwG80ly4k5D0h4QAE08gKj76zlJLj4Hjz
	 2Rx6ejv1zUx+IlNcF3q1bSSfASRayuZspOwqmIPgo7C1/u317Ay6A2To7FBIfy+gzsrUW
	 Glru6q/8ACWfl++Et1hX2MlCm5ziJSkT4YkNiOIJtyuPKvnVOPLwkUL4FUJTdk+rjkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="r9It8b/N";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DB3606A321
	for <linux-rt-devel@lists.linux.dev>; Fri, 27 Nov 2026 10:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14DB3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=r9It8b/N
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8c6c06b3321so6285043b3a.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 27 Nov 2026 02:16:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795774611; cv=none;
        d=google.com; s=arc-20260327;
        b=GjIbNz63xBxA/V7ejvZ/VS8NY8qKi6LUTsVm3WUCTO2jJV33SHBIBcf2XG+L7ENNEv
         l+0U5J2sYjr1MR0UnGJvejnY9g9yZoaMz6z5Jw4/bxM8J+Sz9bCWpb/Sf7gK2Hta7JeS
         3u4GJ5hZ8LQ7LpjH7ZGwL7B7iM3vcgutatnDslA50RyiyRLgs4lEsDN51vouOkWjO7gd
         ehlZAyrumPeknN/0uXucmf/qG5xyIYrCYGUDSNHDxFR7yDIGffZzXmZ7bpeCkt33H/8m
         YMmb0wrjSKfNoF1sEONgfmdzCqvleZAJ5zGbcs0Sm/vbsK6lyWQJbgiqRdnjB7dknw0G
         40Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KPXb3DtqJNanqI7IPB3ZYAV4XR+6OEYsAvkDzB1Mb18=;
        fh=AGRke3kVqbGL55+UJ4VBBZyRPfVbQEAAuA06eVmb+N4=;
        b=s85wCXhGRVYgoLH9V9AMmzu0SuSKbpIqk+lF+a664oApO+mcAf4/18QQL+WhDjdP32
         P1fReWxLwQtzwhWYd9N7zq5J+j4U7emWXIX+CQ78gWsi5wnS7b3bqGFNgdCjOWAxYh4d
         mgAcHU0/9hTk0ekDwwMNQhLpLVaUQTnSkhmk22tLGi6JsbzoC4MYqxesWzr/p/Dg32yc
         X1yHfpGPr5MBtUCE8FWnDXgXDh70zmB2SyT2kAlzSExG9T9CqjqgvylTBHhJBFngMVbe
         MhVmot5V+Mqki/nMMbHHfLAbS+WIsIa7H+sMZdoE7HKmSZXaHRqZr/vcBlRwJX1rP4tB
         Tsmw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795774611; x=1796379411; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KPXb3DtqJNanqI7IPB3ZYAV4XR+6OEYsAvkDzB1Mb18=;
        b=r9It8b/NA4JiFsSQbv2PtWPGiXx1L/fpRHkWU/ZdYIV90rGIoVDG5X+AdUHQAqs2Rn
         wT8MX2irwk/dsGEv9ZIK+JCuM7vlaUKi+fmFRBs9WAhn9QZCMGUw1OxezCO709Ctg0Gl
         c/bsuBwmWUNKF1qATaXu68UVRPFECOUNfXV8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795774611; x=1796379411;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KPXb3DtqJNanqI7IPB3ZYAV4XR+6OEYsAvkDzB1Mb18=;
        b=XXhWGNw3QyPmssWlPS/UhRI2ZN0wMbQ8UKsK9hacS4jSWwBHpdnBNvOjRy1PkgGoFe
         CkHOQdGE1EO1Ra22l5PsjP9HIaP3TV64iAbiaRjj8tY9ExXtyCVzwi3qzyjYs4emw/I3
         GuH+ome177fqJa0jj+On6JtMlBpVXHBxHU04w8CQCJXCH5PhGeSeVFCVUW/nkT3GMhJp
         WpZeLBZhT+zrNqsKH+qs0FPiEJyrgb6MfgpqKXgd577659RjzJBHiKNFZRxI+FQw4Al5
         o2xVb2noL4YmMsezgaYryQ69eLpegtS2D9aHFtvmCEd+W38pNg9OmkOX0/hqr7GquiZw
         7x5g==
X-Forwarded-Encrypted: i=1; AL+hErEHCVD+toQ2q3bO6P1x3uBASmw6ySuej5pYx0eRji7KXN+DrrB7B5sRG5LqxD8M3jxNc4XGV9oSVVQrO0DXlg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9+p3m0fB6a6sWDxqDZDycv5AsVKGh9jvt+G6mhXoBD56oOMg7V
	axeWYgibH6132+pgPYSMFIGGVtLi/2h1h9CUQmmiTVbEV22EBbbYm/l8ykxebUYK10DDziRjENF
	57H1hWNLDs/RQo8hrFRorm0ZL2f1vVisFShEV1dqm
X-Gm-Gg: AZFdTZcgO9t83WBHo6eryBP6SkIfdUFUg+JdOUGUbRHqDE2X6sCIZxv3EcIfN0b+HFW
	B+2yDhpEWAuvFam3PP19Pm8MSM8WtVMbgyhVjBduKvpoDMmvjXrXYF1YRvPIUN1yJn7QrnUHI1n
	L8+MVwIqJUQQcrTVW8YTAwJhfOr2bv8yS4zDmXAHWSHHynQ4gUN7zISKgDiBBTyJWrrhXGZu4gt
	5ugueappk4V5XoEM/QtNokaSjY5jXkYmGhL1BKMIp634FpJ9+8jSP9muP6Nn+U+caBCuforcdch
	BGsfe/ml1cmNQcLj8Mz/KSpZ37FJBzYPrNWDpibZFDnYcMywdbxPzZPAYaFRCwfpWmrgiAR+fmR
	NSArS1TZ3QT71P4NkkZ8352SppsucirtlHhjun7DnUpQj7az9Oo7K/q5SkznIdvFj2BlEf9pjZC
	f/5qx/BANfQSJEIWA=
X-Received: by 2002:a05:6a00:f06:b0:88c:e59e:e168 with SMTP id
 d2e1a72fcca58-8c87d519a88mr24868251b3a.52.1795774611339; Fri, 27 Nov 2026
 02:16:51 -0800 (PST)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <ACT-WEXM.v4.r0.20261124074514@mojatatu.com> <ACT-WEXM.v4.r0.20261124074514-2@mojatatu.com>
 <20261124161258.vLyrm8Y4@linutronix.de> <CAM0EoMmMio4kotBqbcJmFtf_c3Du=rhfvp+sMiAd0fHKowv6Vg@mail.gmail.com>
 <CAM0EoMkEjxCo6K9k3MZH0U+3na9soMNE0gouddwOTzUYXcEunA@mail.gmail.com> <398670d0-809d-4cdc-b03f-80bc3b5faa2a@kernel.org>
In-Reply-To: <398670d0-809d-4cdc-b03f-80bc3b5faa2a@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 27 Nov 2026 05:16:38 -0500
X-Gm-Features: Aa3M54pNs2p-3UyS5EML3h7jq6W69RH1lzjUNliy6esxdQanlDs19hCw9dfN8zc
Message-ID: <CAM0EoM=ZtRjDfV1TNNopPyON3szx4aDMn1Yp9oD-dVMVq2QyAg@mail.gmail.com>
Subject: Re: [PATCH net v4 2/3] net/sched: act_gate: refuse schedule entries
 shorter than 10 us
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-rt-devel@lists.linux.dev, Victor Nogueira <victor@mojatatu.com>, 
	Po Liu <Po.Liu@nxp.com>, stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2026 at 5:14=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Jamal,
>
> On 24/11/2026 18:11, Jamal Hadi Salim wrote:
> > On Tue, Nov 24, 2026 at 11:58=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> >>
> >> On Tue, Nov 24, 2026 at 11:13=E2=80=AFAM Sebastian Andrzej Siewior
> >> <bigeasy@linutronix.de> wrote:
> >>>
> >>> On 2026-11-24 09:12:09 [-0500], Jamal Hadi Salim wrote:
> >>>> This is a followup of commit a51c328df310 ("net: qos: introduce a ga=
te
> >>>> control flow action") as reported by Sashiko.
> >>>>
> >>>> The issue:
> >>>> fill_gate_entry() only rejects an interval of zero, but that interva=
l is
> >>>> the period gate_timer_func() re-arms the hrtimer at, and a few
> >>>> nanoseconds is below the cost of servicing one expiry: the next is d=
ue
> >>>> before the current one finishes, so the action holds a CPU in the ti=
mer
> >>>> softirq for as long as it exists.
> >>>
> >>> The timer is programmed in the past, fires immediately and hogs the
> >>> CPU.
> >>>
> >>>> On a 2-vCPU guest, entries of 1 us and below hold 86% to 90% of a co=
re,
> >>>> 2 us holds 61%, and 3 us holds 22%; from 3.5 us on the cost falls to=
 a
> >>>> few percent and it reaches zero by 100 us.
> >>>>
> >>>> The Fix:
> >>>> Require at least 10 us per entry.  An act_gate schedule is not tied =
to a
> >>>> device, so unlike taprio there is no frame time to derive a bound fr=
om;
> >>>> the bound has to come from the cost of servicing one expiry, with ro=
om
> >>>> for a kernel that services it slower.
> >>>
> >>> The 10us sound sane. With enough debug (say kasan, lockdep, =E2=80=A6=
) this
> >>> might become tight again.
> >>>
> >>
> >> Agreed. Unfortunately, there is no way to derive a "good value" here
> >> (it depends on workload, machine, utilization, etc, etc).
> >> poor choice of wording on my part - should probably have said all of
> >> what i said above for precisiness...
> >
> > And now that you bring this up - this should really have been
> > targetting net-next not net.
> > I dont want to resend (unless sashikos find something sinister) - but
> > Jakub/Paolo consider applying this to net-next instead when the time
> > comes.
>
> I'm sorry to say that, but a new version might be needed: it looks like
> the new tests you added in this series are not passing:
>
>   https://github.com/p4tc-dev/tc-executor/blob/storage/artifacts/928799/1=
-tdc-sh/stdout
>
> It started there:
>
>   https://netdev.bots.linux.dev/branch_deltas/net-next-2026-11-26--21-00.=
html
>
> Or is it due to conflicts with other WIP patches or something missing on
> the CI?
>

sorry I broke it - not sure why our system didnt catch it before
sending. I will send and fix the commit log whining from sashiko.

cheers,
jamal
> pw-bot: cr
>
> Cheers,
> Matt
