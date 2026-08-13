Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1533B411FBB
	for <linux-rt-devel@lists.linux.dev>; Thu, 13 Aug 2026 06:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786600804; cv=none; b=qwCYgtpyi1PW677Lbf9a+xYuLVEwaRbrUoWeDZrYNe+uIHGGaRWIWu5bW1OTK6VUHTn+ifpiJwGZCpsAJL5RippDAtHoZJ/VH8oFO9wm873eCO35auxlTnTGVpsPSV7QyKO1r6PZAk0H7+j4uNtbdSmfB05pOyUROOpBLAdsIB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786600804; c=relaxed/simple;
	bh=dadrcgxZ2VGij7TkJpN8P7nmgIBrCVXfpHR/o0agZ0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRL7YfOD0n4I2SBsZ3uRkQb8E6f7SO3iYhrexiYIQC1dT9fNim91JyeEpaPuuuCiYcwLW0TcOSnl4jKMBsLXDop2b30NIPcZHMWkN0rf5wBlPlngfBcAxvxTGGSN8Ep7zKfLVVmGYjFyWzrEw2MiAyqh51x+PFgewTm2GV9MX8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7ml6yNm; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7ml6yNm"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so1643511f8f.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 12 Aug 2026 23:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786600801; x=1787205601; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YfObPab6712OhhB848BHWwyLub6SBCc6jSsmm/kgkes=;
        b=I7ml6yNmjh+/aPR1IIHsEAWeLgYWo/6zPOBjSNDeNnxVKewv7OP05xu1IUgXEq1plP
         OUaT5gn8gsyESdf7/xCKmiy74BJR7DMeaRV6x2LRAb66gsIBSIcSNVufv5l9x/auRFMM
         jFMCW1vLxO34hFEEGXqBbJ9CVeLMYNfW0rnbtGHWv6kH/Cs5aeNHd50N5Ww2frgS9tW6
         v32QUSQgum5TNC9+Cig/10+DmPIbdpvEbDwfwPDr5/1BfEatPwkpYJ49v/G3u7PFUHiS
         EaP2bxQpLRLHaEwq3/T2/VRu7ooP24OooFMp9Urs28n6+qiLyNjR/nLZQ7DpJjpZHgS2
         mmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786600801; x=1787205601;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YfObPab6712OhhB848BHWwyLub6SBCc6jSsmm/kgkes=;
        b=BLp0itDcwCynl+MRlbm+UaLiqIbHpanDL8xzKgfKSVjkt9T/zMHKT/L92oUo2mzeyi
         F6JZapc3d3G2NiNHvLo/IpDA6+oRaYUbZeoL1vAUbUTKwYk5mk80aNDj4RBVegiSq6k6
         dEE8JW91e7Jt40C2olxm439tTZ+sQigfcAA8JX9PZh9khweu1Na4yH2kRjxAiwaT8nCu
         tCfEFIuAw9PKsC2krBzXDTO25iXAcOGc25o021b/ZSwwAFQI5SuiOVDzdzpsNi4MRlkJ
         UVGUmI9wJO8NkKYWUQJs1V+slC2iPBmRK66w9AZAkj2kEe9Rh58aFMP11dK+zRrc3FcP
         eJnA==
X-Forwarded-Encrypted: i=1; AHgh+RpYubxbgWxWDjvpYk77xv5QnSXYZkr8Iz6qmpA0vR7wRxO/EYn4ZJLmt8vOZc54+17Z0cIT8bdynK7/MX1D1g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxtdk1Ygw2pOzQsadQ27iDpVQ2s1QAOAzSINEY77gTCgKxu4fTw
	3elS6kKzQKs4U6uGk+J5FA/sSepTw3j9UutrFX8PlZtYb7032IidObXT
X-Gm-Gg: AR+sD10ZzWF6CyQZ0sXwLhYIkEzCTUapWtlFATjK/v7jv4ktr2ffHmQZE5iDaKilooV
	MPUIWNb8WeJN86tnedJJaDVPYjfPiuvVcJ+k0S5dsqEf1LyE7oE4wxQ85/yEE2GCQzY6UDKvb5P
	hlRmLaJ8JM+jkWDje/xf1ES0E8v2MLr/DBF5oZN872iWfRaGL22U0wo6th/iqefO1mkRZCBv+1G
	g6aqXX7m9LBtDn9PbjPGJirG5BASvaueYY1U/22w65qZ/vQTZlNclhd0+/s95Ie8UlKsWEynAUy
	0bi8ay1445ODn/HbgdQtuzwVlENWVVCV97Svfyf9EhvrhA7bhQR5aqhH6xalsXlXmKzQLf+fG1p
	1kAe4i5e9aP9rV5tQrSnv0Im9dTI+6HuYo0gsFokL2IVedRp8VOwwN5s4NWKN+dzpOZtgoCPe0s
	15O1b/bZgPHt1Mlnoyt0Z+0tWOF8IhLRK3r9t1yO6VV5rWoQqWuvHODwAzOGE0nJnjOTcBUfkbh
	NYbXW2TBXYRbzi4pUQSWYbRQMBZivMWHqyaExSIac8Wlvz9Iphb+9seY0H+S1jWpfeApZrfDIA2
	NvuSoxOoN6D19xi1aSv5m13hMSawFOFMZCB+lt0YV+hf29+WA6KBfGWPElgQlDsNMHc=
X-Received: by 2002:a05:6000:3104:b0:47f:773f:2d68 with SMTP id ffacd0b85a97d-48159eea061mr4408522f8f.16.1786600801086;
        Wed, 12 Aug 2026 23:00:01 -0700 (PDT)
Received: from MacBook-Pro-von-Karl (dynamic-2a02-3100-9c79-1f01-1565-573d-10dc-99f9.310.pool.telefonica.de. [2a02:3100:9c79:1f01:1565:573d:10dc:99f9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5af4b2sm3155862f8f.17.2026.08.12.22.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 23:00:00 -0700 (PDT)
Date: Thu, 13 Aug 2026 07:59:57 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>, 
	Bradley Morgan <include@grrlz.net>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	linux-rt-devel@lists.linux.dev, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] hrtimer: Pause KCOV during deferred rearm
Message-ID: <an1dEVKGlwbusXcS@gmail.com>
References: <20260811154111.64669-1-kmehltretter@gmail.com>
 <20260811154111.64669-4-kmehltretter@gmail.com>
 <20260812102100.GF776954@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812102100.GF776954@noisy.programming.kicks-ass.net>

On Wed, Aug 12, 2026 at 12:21:00PM +0100, Peter Zijlstra wrote:
> > Deferred hrtimer rearm can run after HARDIRQ_OFFSET is dropped. in_task()
> > is then true, so KCOV attributes the instrumented timer-reprogramming
> > subtree to current.
> 
> But that is clearly noinstr code; there should be no kcov calls in
> there.
> 
> If kcov is emitted inside noinstr, then kcov is a broken piece of crap
> and needs to die.
> 
> NAK

Thanks for the review!

By "instrumented" I meant KCOV-instrumented. The selftest callback comes
from __hrtimer_rearm_deferred() in ordinary .text, not .noinstr.text.

On x86, irq_exit_rcu() runs in an instrumentable IDT-entry region.
__irq_exit_rcu() subtracts hardirq offset before calling
hrtimer_rearm_deferred(), so check_kcov_mode() sees in_task() and records
callee coverage for current.

This is the same class of failure as 477d81a1c47a ("x86/entry: Remove
unwanted instrumentation in common_interrupt()"). There the hardirq offset
had not yet been added, here it has already been removed. Its callee
could be inlined. 

Deferred rearm instead reaches shared hrtimer, tick,
clockevent and architecture code. Statically excluding the graph
would be pervasive and also lose coverage from ordinary task context.

Do you want deferred rearm and its complete call graph converted to
noinstr, or merely built without KCOV instrumentation?

Thanks,
Karl
