Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E41C13DBBD
	for <linux-rt-devel@lists.linux.dev>; Tue,  1 Sep 2026 05:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788241810; cv=none; b=qa3uie9XLZW+mZiDrvqqCJpKNmfnsQpLDbST0nsFrUH6mC2cEw8hRMngRJHuGbM2sbFAoxTLBqc/vFyIflzTdWRGyPe1FqHie5h2/Yf72kJDWeOHVk4LYoYctsSw6sSFTTpwqQANFtvqX80XBjhI4/pXGE7aXuC4J4xOFIeNrUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788241810; c=relaxed/simple;
	bh=pnefHhZaUXtX9LZJSQSVuGsmrJHNS4fDTg5BE652prU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfVm5pHPzH4O1g+G8/Yju0cVm9hYqsoDPQA5U21bZ+For6WU+MH95s0KYyOitd2qcS3b+bFny0LM5238w9vOtbBjW1Gw4Qk3z9eW5cFlgdbHr+ENLJG190KWIb096pnZIsIskdKbmlaiUAcAQxIREi0aB/EW2v5wBctnL4zeX0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbDcpwlc; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbDcpwlc"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so43207795e9.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 31 Aug 2026 22:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788241807; x=1788846607; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4pcXHVNN/f/FBlxkFnWJyCbKKWRhxlmaVfGPhM+aRWo=;
        b=DbDcpwlct1EueIWpdRGPcMK+I4Rn+BQvn+yVLcm2OwRvGE4VJ8neicw3zVoUryORhD
         +1tgZATqmdHPRzz8F87movx8mhgZGHmKAVZ/gQW19dzFgsdjNp6NZWUjxv4TcgWACfvV
         V3BFEUEeHn8Z9ejNNFdq74EGv86kPsyg3O1N1vPrscjjnb3xQNr07hwkObmpa/M+qnOL
         tO8iRPFJPIvU7io9Y+3BoqsFJdlx6ME944UBIfS06fXmZcBUoxXAeQTn+g2f4UqqQ83h
         aLDWlIbW8O2DBLBGRD9s9/4rTWQh0S7wY9mUH6p/Dy/hmTeybevvmfnrwjAUNHd4T0XR
         VfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788241807; x=1788846607;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4pcXHVNN/f/FBlxkFnWJyCbKKWRhxlmaVfGPhM+aRWo=;
        b=PlPIMQHsRyPoSAoyUW+eWVRSgXPuh6SBtRP5sucsg3b5CZPvIRd1Rd/20bFB59r/Vo
         JvanAvWChhYgzQ6JvEpf9PTG8PMusRsnZ5Kx4Y/E4t9suUWSD2LiBNYB9QQw6NktB3Yi
         XoHUV0mnWypLcEkUWWBRrRnoYI+iSQDWGEcFb4DyohGG7BLBQSUR8UnujsMOHIKWrFbN
         yQ7SMFA7vubSu3isRTHg7huyB7+yjNOBEU1Um+SdtM1H5d3axr1/YEKJ74Ebn24ZNyrv
         m5WLVZqzlCSAzyYMeLg7cKlFpyJdV0RsHCsUll7wDa1TEkDMmuqveHcq7i+ldV3xmZN0
         sQkA==
X-Forwarded-Encrypted: i=1; AHgh+Rq+ThA8F6A5XO04rduPDH76cokKprjK/si5RPG8U9jz32Q2weEMiOndIMthaUIOasGNRMKaufTEokWaYkK/bw==@lists.linux.dev
X-Gm-Message-State: AFuF++l4P8eK8W+z5so212862zfb9iMI9kw4p/8Be+2/+4m1RIqoldJ6
	b2av0dtUrXoou8xtrqZ1TvZlU1e7nbip11UAiklNgWXaVpUvJ/3/uvi6
X-Gm-Gg: AR+sD124WwU5vS1z9ZrbmV+c+07c6Yy2D72tOOgDnh7ow1uVO9Ul1AITaKnrH3M//bi
	mp9Q1hTneO/hyf3PfeqV7rg/0gE22I83q/+b+adn/NNAQ2amQkPtT74EoxDERafM+mkjLM2MVTf
	yz0bBnK7DorW0bUaCQd4+hycrxdgjuLwakt5nH8hB9P14jbOH1fjQmG3rCC54nPAqitF9qLnrPb
	tB7oScdJOcwgJPeMUcWEAs+2kD6k6oU2lN7xieD4I1aCLRCLqHLRabI5bU6WLswTkd9yxzF01Ul
	9R+PBfcyydwxqBL/UWao39d5KjwBUTpTxmV1vzVXG2EMkD66IXdnUWimjN1kYBRgUu0M8hVlUr6
	JEYFHP76rN8gRgHD4ggZtlWi3fFCoTnYsBvfirjaXhGqeb2pgVPX+3W9NtNwn1UgLMScE0PykRT
	+8ksLOqD06to6xB0RPimtJn3+TmUPAIO8M7ulqfjEgdSnqvg8W3/pr3v9Px0lUN/q/gD/Nf1O4U
	KJTLB4XnK6jqdocwP1NKhVNcUBN3lR52MKnDEREuvQRBobBQ+BjnTvU9j3Ne3bBhhCUbYUpP9OF
	a8Gqxix1n1fMtduD+TMLi+YVu0QTbQTAWo2fF6qK5FgPeYTZmfswIhL9qDS73oll/g==
X-Received: by 2002:a05:600c:4f8b:b0:49a:2c4b:403f with SMTP id 5b1f17b1804b1-49b91c46494mr412146165e9.13.1788241807067;
        Mon, 31 Aug 2026 22:50:07 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a16a-7801-fd8c-4b37-36b4-e53a.310.pool.telefonica.de. [2a02:3100:a16a:7801:fd8c:4b37:36b4:e53a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce11e0fsm40774365e9.9.2026.08.31.22.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 22:50:06 -0700 (PDT)
Date: Tue, 1 Sep 2026 07:50:04 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Marco Elver <elver@google.com>, Bradley Morgan <include@grrlz.net>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	linux-rt-devel@lists.linux.dev, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] kcov: Suppress timer and scheduler coverage leaks
Message-ID: <apZlkC1lCUFFMKsl@gmail.com>
References: <20260811154111.64669-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811154111.64669-1-kmehltretter@gmail.com>

On Tue, Aug 11, 2026 at 05:41:05PM +0100, Karl Mehltretter wrote:
> 
> Add a nestable KCOV_PAUSED bit and a kcov_pause guard. Use the guard for
> deferred hrtimer rearm, __schedule(), the try_to_wake_up() wakeup body
> and wake_up_new_task(). This suppresses their instrumented callees
> without excluding those callees from task-context coverage.
> 

Andrey, Alexander, Dmitry,

Could you please take a look at this series from the KCOV side?

It fixes the CONFIG_KCOV_SELFTEST failures covered by this series. Some
architectures still need further architecture-specific KCOV
instrumentation exclusions.

The three syzkaller A/B pairs from the cover letter also suggest
better coverage: at matched execution counts, the patched kernels had
14-19% more coverage and 42-54% larger corpora.

Do you think the pause mechanism and the places where it is used make
sense? Do you want me to continue with a v3?

I also looked at the Sashiko dashboard report:

https://sashiko.dev/#/patchset/20260811154111.64669-1-kmehltretter@gmail.com

I don't think the remaining warning about reordering or removing the
kcov_mode stores is real for these call sites.

One small change opportunity for v3: In try_to_wake_up(), I would take
the kcov_pause guard before the preempt guard. Cleanup then runs
preempt_enable() while KCOV is still paused and resumes KCOV afterwards.

I would also replace "uninstrumented" with "built without KCOV
instrumentation" to avoid the ambiguity Peter pointed out.

Separately, I will look at turning Peter's IRQ-exit preempt-count
proposal into a standalone patch for instrumentation in general,
especially KCSAN. It does not replace this KCOV series, since it only
covers work run directly from IRQ exit.

Thanks,
Karl
