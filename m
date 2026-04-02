Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F3F2D47F4
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Apr 2026 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775138319; cv=pass; b=A/qQM7L0CFJSpw3GE4d0jvGBb2z3Gq61H3eLtME+eOPXG9gAN2cymBcU+Nb5KzAPkuqQrsQu27S7zQqg99AxB1/6PVo5cCIaNjDbDDgHGbRQYwVBMGasDf/lgyrfD/RjsJ4X5HWUufjbhGU2B+lpaSZZd3RSBgbAixHrcUl7afY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775138319; c=relaxed/simple;
	bh=VU0AbFtlLFJSKOUB5IbB1iaCG7SEJEo5AKtWU3UUzNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nm2RN7zhP+52mhLQq1kuR2R32aFRRMFqJnIleJ6uwUcJiJtUaSs9Jl5s+dbC7xmNwsoT/h5BH6Qja2AZXcSOCDobuG52GckHC7q1lPiGGI/8gzSJ8cwXzqQObc9A7f5j6edf4I4dewnACRq9k7miV0j/CWTVqX+iiGgV7LtQfGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SfYGyi+o; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SfYGyi+o"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so849100f8f.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 02 Apr 2026 06:58:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775138314; cv=none;
        d=google.com; s=arc-20240605;
        b=hFidOFTqfI6c2l2iejqjMPyHjBaAexE2g4WOLmhF7Wius1wddJS+oMR+sINRyENm6b
         9MboRNkMsffZDZhiztxSMCYKa+b1WbhCieqqfY42mwxeFJv2xJTtjKQNOvZ5z1mFHtwb
         SzOjuWcwFrdkqf0mO8gLnc7sPumje00iCfL+/lWWtNbeo/0teTFNEs0qcR7PJ0ZmDXRJ
         p+weciEITu+vr93xKlFybVsWeuO/yc8QU9GWkpMX/AXXZCNfzfNTsbaroOVx8PUu+Tk8
         Hm1ccHytt54ktRECVBug++CbpE5D2LgcQuxcHs2BPdW9MqAp2O8TNXcy2N260zjETYzR
         DrfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VU0AbFtlLFJSKOUB5IbB1iaCG7SEJEo5AKtWU3UUzNE=;
        fh=BkPMLxxJdUGR1u5Kxdl/D8RS3JhL2N947UFePJ5JUfM=;
        b=A4cV+amXL8LPRRs3UZJATYoxHhalWN1yDExYk8DHKx2jSXLMV6BmgspPBYgke+9dN2
         sFVZrtdusew/yH5g/+ozcRC/7m5X1FG1aHkhGYNQHUM0F7ZimGv64cXYtXBnwE45PokV
         o4UiOMEufqXbJYz6BeOyrcft/KI5sXPNPdNF2MOSfD59+a44UmA8qv+iknnms398RTv/
         tUQwQyoSqJRG1U9nmEabR5AqjdATmKgbG85pyAADHKuP30Ar0UH92xFGRsMoDpnmPbs2
         zUhXqIL/jKcwC9Rey1jL1DZ+6b8gAhvqiU/K2YghXVAScUgE+Vk4JC6q6z+9JyU24V48
         Rxkg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775138314; x=1775743114; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VU0AbFtlLFJSKOUB5IbB1iaCG7SEJEo5AKtWU3UUzNE=;
        b=SfYGyi+oo5xt+BBpWqndGyFO/R4vM1s6yfvWJdir4idUVGY2xHSu7XxCtosR3uJV7r
         gy1QpMG2kqHhsHgZ1m75bdYOzVctr9KbQIEiWC0i7gC3uef7GVQkPhSW6QV40VrOzS8Q
         QKrCfdNfB9si6xaef/i6WNEo/PwwjeJcH5ce71OoFFax499GWRx8WhlXrdYGdNQUoPzT
         yVTLTFp4PswJO1n49leChwnB5LjDa4YTXlMk9uU6dY9BmTkM9oPRJf5hAAF9mIn69QoK
         94TkPMXP1dSVSFn4vQkYmWzFldSGDeB5BnmzbctXh3j5XLMucb0Up5Z1Zkf/dc3ngIxl
         d4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775138314; x=1775743114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VU0AbFtlLFJSKOUB5IbB1iaCG7SEJEo5AKtWU3UUzNE=;
        b=TkoVlAl27Qaf/CDFVJycTo+iLnculPAN5QQHQ0Jj2aqaFDj1ZVj1K0+EI6z2gKo9/1
         3EfLIkkvKfxxHjgn684Y7FYk+ls4ACG7tfik+RnbWDyZ+fmx5G9nF461pjKfVp9pudHH
         RWnGoeL4VDxpv9G7T93xZ6ISwLzfS+VYVg278LZqfk69t9jNWyCwIXrCgjpkD3vuvJg0
         qmZ0Skxjly3JL+uOTg4MSYh3J4pvvArH/IxC+oDhYqYiP6K0SXdo8/XTP+/QngPd6+fI
         ma56Dpft7INWsFHH2Z6F07fPB45ZO1crnre8SU4KfClecrKnJwhDT3Vi6OHz3LIvejZ7
         fTzw==
X-Forwarded-Encrypted: i=1; AJvYcCXn6MjsLFDNXL7WZy8ochznH+VT0gZ3E+2X12IkBfx1ySxQsphl606vD3Me1zk2ryK+TUvqenq4xqezBcFJKw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNWLC+g1f/1//3B38lz5p5muELvbQ6MOMEmm7YVxkeDfLdJjRI
	d0TH9cJ++cCA9XEqixn4Kmga/L0VT7GYG16jBhC2hd6ef6XVblmckEQhr0xc65c9x86vxNM/mGO
	2QEftMv2WBeeG6YQn6m+HjO4YtIAwUOegNXhITP+pjQ==
X-Gm-Gg: AeBDietBbljtK/F6dV/YUvCovNDrHkFWiSdRgAR5avOBe3dvQZ+c1EoQ4jUsJMpNan7
	jdtgnVpwqAzNsdGAZnoU1pt6ambTM3vSfBA0z3yXqSYXpk/0j+shjtDMBhL9kE2WlHa80B5E52b
	VislK6UKfnzc4M6G84u4rpnLxytzmPulyl3qIuLZhKk+XADAPk/Vg5THSzBotuAL0K4KsyDi1YH
	HGEenZICtz4JFcym5qs4dVTRxsIY2zxXeAfIoEchVfmWc8ZlnP9mHdZnqLeqoGRz3ch3ThGuTVv
	brEwFfGWNSQL7jZBEgXxOw9BnPqQuoq0Xmgqwa9QKIyBppnwu4Xx3JOlH59lwahXHtSIWrODGkH
	eSnmo
X-Received: by 2002:a05:6000:2010:b0:43c:ffee:ee95 with SMTP id
 ffacd0b85a97d-43d1505649emr15414743f8f.16.1775138314295; Thu, 02 Apr 2026
 06:58:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260226172927.2Ck9wZMw@linutronix.de> <20260318103009.2120920-1-neelx@suse.com>
 <20260318111849._MMol8Hr@linutronix.de> <CAPjX3FcRYNkYK2gerbRL4C9wXZPxWSs6=oTjzv5+msm4PQrfqA@mail.gmail.com>
 <20260318145101._iaDDpbE@linutronix.de> <CAPjX3FePCKQTaxB6zuo+_V09PZct=utw3vgJUTM_GrZQtv7_TA@mail.gmail.com>
 <20260402070319.vhRd6c-f@linutronix.de> <CAPjX3Ffz22M_ADE1xPqHOCyni1wLwc+reLTVyOrJ+gqNYY6vwg@mail.gmail.com>
 <20260402083123.1H4kyAEn@linutronix.de> <CAPjX3Ff8Zv2EArKaCSKFAAFfBCCVu0YgqHk3SV85BBPm6-D7HQ@mail.gmail.com>
 <20260402134633.bRxz1V8a@linutronix.de>
In-Reply-To: <20260402134633.bRxz1V8a@linutronix.de>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 2 Apr 2026 15:58:22 +0200
X-Gm-Features: AQROBzCJXTJV8hcjctLKcmZ2hBR3GmC6EUKHtExZ92lQyFZHUvwnLJh4BAs_1v4
Message-ID: <CAPjX3FebJxdSMJV9Qs=3BtgL4mT7q55C6Te9c3OqpUhR5C+Ekg@mail.gmail.com>
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, netdev@vger.kernel.org, spasswolf@web.de, 
	tglx@linutronix.de, Aaron Tomlin <atomlin@atomlin.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Apr 2026 at 15:46, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2026-04-02 11:21:20 [+0200], Daniel Vacek wrote:
> >
> > Well, that's the patch I originally sent then.
> >
> > https://lore.kernel.org/linux-rt-devel/20260318103009.2120920-1-neelx@suse.com/
>
> That was an alternative after everything was already done.

That is true. I don't mean to complain. But also because I haven't
seen the applied version on the mailing list. That's why I originally
sent my patch as a reply to this thread.

I'm simply asking whether we should proceed with the discussed
approach? Would that be better in the end?

If you don't object, I can send a rebased version along with a
follow-up cleanup.

--nX

> > --nX
>
> Sebastian
