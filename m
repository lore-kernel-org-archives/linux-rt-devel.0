Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793452187;
	b=lCGNYC/X8IBZVT4nx7Y+mOgklIjzioGrZmbSghCYhWDdMviHyS/MybMUpO+un7Tqv1Fv
	 yJXDUYmkbdiEUrTzQ/pkYDEv44JNjV/2pSFNGrr4Y+Q39Co1qJ5SzPKJt4Y1oMRiwVNy9
	 BDyeYRcQFejJYFE8ka0d7sapzr86DsRHd1b0tCdZTf/pZkGyDQCwYm8/dvx2QF9tuzBON
	 /O1+lrmp8w6k69gj4RLlVXMSzBLiOFu9dP+CaqeuhfUpK1YDyta8535idZlsb8G8NFAl3
	 TtU341V7cRZCMFgSdkMEODrh1JZnw5XoXT/7ajLvu23UtcCr/3HNTX69bmWjGEvNORw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793452187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=AsdiVPeKCV3aUvIOkRhblwdU+P9wwsjvQNPDztlCLtg=;
	b=JtCJBewt7oBGlcZpCU1ElNa5k+yDoaN/vZQPO1a2ZVf/5gWsmGctyjCclc+wSRqWqcvR
	 9z+VCAfZ28V7FQ6k1brVG5H1JaXMoHSppv0N+u0KrLKxWphDANlm4bjEbx47mYoAulW+b
	 k6Q1d3qtFoUnp2vvjSH7TdQz5yAv3Rx0Kw9a7BGNcRrlEi4pYkNj6E3IGS3u8k8lKyYA7
	 McNaEiuNgVj3+MhO6M3QywTHjCSVFYjrSTtYxbXhsehdAlFpC+jpOeHE8JCGCB5IgvZiC
	 7W5U8Y4Fyt0i0i2bfcvbtVzeTtflYuNaBCwAcYfM1FLF7coxSg6rWKfAOcJ4q/rZiIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qHaCOb8r;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465A3606A31A
	for <linux-rt-devel@lists.linux.dev>; Sat, 31 Oct 2026 13:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 465A3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qHaCOb8r
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so13923845e9.0
        for <linux-rt-devel@lists.linux.dev>; Sat, 31 Oct 2026 06:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793452186; x=1794056986; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AsdiVPeKCV3aUvIOkRhblwdU+P9wwsjvQNPDztlCLtg=;
        b=qHaCOb8rYCh2h5myFPGO+oWmGrC8r3P4Vuua7rpuZecUxFhHF9OtrnxKaTswS2/r/C
         Gopdpaz7bc4SrtdValGQ+VFXufyEvsrbh36brgz6elADiqmbMmsL5uR/lW+LgQv5E0h5
         0jZpzFgrXAabs+CoXOvfG6frXs1TE8Zao4oMn4pBcLWFAAjEqJJWFlopKGelQm9sTHwy
         zG1u/Ri55BaDzfB5g/cKg8aq5rK3OJZW9Bk/Tdu1kCiuyNL6vkJJFaEpiPRXfDOwouDt
         u8yZvDznaYqGlYLK/+n2UeASrJ7vv5y3RzJbNM5orGV97ZMe+xp9t23yZ0kewKXKEefq
         nnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793452186; x=1794056986;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AsdiVPeKCV3aUvIOkRhblwdU+P9wwsjvQNPDztlCLtg=;
        b=suAdSs949Dl9UnLmAzOHz72FWsx+VwQR5ZSZQf/qnuH+nd78ZrIkEXJCwvNQbN330N
         nfWMdZVWm3rDtfric1dID5yMJx+AAFG18Gsk8QB6s63Hikl0fWwowPn5vTclfc2LHsqL
         9p0kosRo8K3+hY1EGUaAzq+jm4+EjO96RhfWIi7xiIRpOa0IbFOG9v9bykJxMieggBkc
         C3OEWQvN2SJq+sREMNNI2SUVHT3Kd3Onc4j7yYb4WpkG8lvAJW7tmhvKFeUD4T4+jsPX
         X175fe4Ipco5e1CnVIV4gdoWJ2htM/aUCanLm7ccSU6nmK9S9i3pyJaN1zsq6xdy7LTp
         ZiGw==
X-Forwarded-Encrypted: i=1; AKwUvBy/D1oIq6uhEFGESk9EHLjeEWhS5kvrezCklr+dmZpPJcDtj1gIFq5SgpYcwBxYsU+TbiSH9ydKjtNusimf3Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYKhoGH/Dy8WZMEQmqkv4PYu3xg/zLAsR/NhoPWFJ3p08nkPIHN1
	uORbivHqm/iCmeRHhrULqp/w8Z0VgDWbKBwtUZYt3Ug2eo4Yynl9Z4TM
X-Gm-Gg: AYBFou2x6A1MTpSriI9f+n+AQ4qOl4yj80cRz3YGGwchr2/lfintX5+CgLKqjUngltW
	lVBRgyw9iORJBeXT2X2zlV2pLGeIeeVhyIXrwNccJlQWMDcbP7Y7Jx+LGebhTkty2ZtSIjNm/w5
	cWsCnw1RWeCCEsZ833vFv9nB6ZI70CGm+S8/z6JYqYHMn+vO1gUJU8Vj7jpYRuAbBV/RXH3JzHu
	B0mJoNeStzouhjron4vq5lJsJcgPdW8EgcYPEPou+d1tbBNk8nece7E2oOU9Oo0SK6Oo9aKX6R8
	+6aTFnP6xpReaxBtpumviuBDwc6QpZnmGL+ydEGoaB1KWyRFISsQduf7MW8vC3LUizQvXlEfbUC
	VyrMmi2/uWtgEyVRxKFA/fXlx4pGZ3S/fwdKDA/gYWF3nxLRofaiHrEIo0rAygjFb1U2PZxCcT2
	3aUvX7IlhA8J6UC8uAZjRj74bDRLr2Q7EONuNItDMjcjt3w4vsbS1Twrk52WMMQoCAFdXGhrbyg
	HLJio/KuvExbpaXt75VoepWQIqYzaf3Izx2NTZAJbrwInsnaMyJDWdpF/Q5wxtXlaGEagVprTgD
	nFqOUgGmfn7Ta6j1YWrK1SWbf86RkJ+gGTBdnksiUcmh+CKQqT/DFFKU+kS3F0NAIrJn1kkBStr
	2Ufmu1gM0k2XPI+wxBI4TG1qdnIn38Qq9qzEoStJ7BWhxBE1JuVbcTC0Yq4sMcPDPwpz/3IZ3xm
	2zrtQVMmRGRk6z0YUe9UDs1iBJq7Briml9gB/8KzCpHagx1nQQsg==
X-Received: by 2002:a05:600c:8b01:b0:49f:c5aa:9ef4 with SMTP id 5b1f17b1804b1-4ac16fa4f73mr122793835e9.8.1793452185480;
        Sat, 31 Oct 2026 06:09:45 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a81d-e001-9c9b-db33-f166-0fda.310.pool.telefonica.de. [2a02:3100:a81d:e001:9c9b:db33:f166:fda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f322c46sm196891285e9.2.2026.10.31.06.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 06:09:44 -0700 (PDT)
Date: Sat, 31 Oct 2026 14:09:42 +0100
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Marco Elver <elver@google.com>, Bradley Morgan <brads@mainlining.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	linux-rt-devel@lists.linux.dev, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] sched/core: Pause KCOV in __schedule()
Message-ID: <auXoWFzEuirP2IuC@gmail.com>
References: <20261005185803.39170-1-kmehltretter@gmail.com>
 <20261005185803.39170-5-kmehltretter@gmail.com>
 <20261030142354.bbc5e7f26fbfb6a8eee21290@linux-foundation.org>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030142354.bbc5e7f26fbfb6a8eee21290@linux-foundation.org>

On Fri, Oct 30, 2026 at 02:23:54PM +0100, Andrew Morton wrote:
> 		__attribute__((no_instrument_function))
> 		__attribute__((__always_inline__))
> class_kcov_pause_t class_kcov_pause_constructor(void)
> {
> 		class_kcov_pause_t _t = { .lock = (void*)1 },
> 			*_T __attribute__((__unused__)) = &_t;
> 		_T->paused = __kcov_pause();
> 		return _t;
> }
> 
> Adding all this goop to core scheduler functions on non-KCOV kernels
> won't be terribly popular!
> 
> A bit of macro magic can trivially make all this go away for non-KCOV
> kernels.  The overhead is probably acceptable with CONFIG_KCOV=y
> kernels - seems it's only enabled for debug/research/fuzzing kernels.
> 
> Ditto the hrtimer change.  Aim to make these patches produce no change
> in generated code with CONFIG_KCOV=n.
> 

Good point. Leaving the guard outside #ifdef CONFIG_KCOV was an
oversight in v2. I will fix this and the hrtimer wrapper in v5.

Thanks,
Karl
