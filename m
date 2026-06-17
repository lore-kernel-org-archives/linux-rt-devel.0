Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B8847887E
	for <linux-rt-devel@lists.linux.dev>; Wed, 17 Jun 2026 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781692659; cv=none; b=XL+pkDSSkL5ga0mfwBnWXFqq2Lo17BMuPG/HMkWWVn3DnY05O1FrpbcV5JTTW62LxqSN0KJbh2884OLkY0DHZREtuODyGfJYiWnXveR6H8Vnd/o0M6Ej+9kU3Ji7haNe7eY3aiNMx21HY8dZAgdStRdQ3K7x7itQM2h+I3ca2Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781692659; c=relaxed/simple;
	bh=7KGOXjbFus1OIBdwidGkbmaAhe5QXQQ88pd8jQjhpr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzsDhpUl88AkBxcOeXbz6caM7DGkRXNcpP+609EVKEpKZ4hMC+WrJin5ggcXv7EDOT70QJtObGxMk029rUxyjGEawBSyfPIeaqZnLlw4912b3ZbdqwO/B+rFDyueuF8ZZKqnkl+ckVftaPk+ElgAi/WtKV7FhVAEau3NZl9+Hco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D35OCK9F; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D35OCK9F"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4631679f204so149284f8f.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 17 Jun 2026 03:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781692653; x=1782297453; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hDhvQwG1QwT5cvmH6BZBllkhAVPQhK/Hew5ZXNgViMA=;
        b=D35OCK9FmRcdrUtqBffgt1KeNyL2ODpIEkY8Rde5eT8l5TLpxiHD4+Vjb7UG6lMJKw
         zjDHzxdEo7msCauqGVIhT5dgkmTBgdmYefRdINh51+nbbIQ0V/o0Dj3zVbxP5SHgJB4g
         lU+SRBfpsWLFCqBIHO+6huSqeGeYZSfMcPHW10Qv4HjbA/KPeTW66tz+4Qift08xrFAq
         2AA5aDTIZqZbZ3hrSwGmkeG4Sel5yuRensGqrT4XBhpZn7mqt32zPNGx2ju1feToMVS+
         GMQQRz6u2BDzIjw9vir/1vzXQqQiqZWBZPe6hgpO+Mo//QRI0NeaB0m6E6N5tbV0niqL
         oU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781692653; x=1782297453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDhvQwG1QwT5cvmH6BZBllkhAVPQhK/Hew5ZXNgViMA=;
        b=Ke6qDxUw5Fz0xUp5EPKeSneHSKeyChdarNyewqPt2fDEjSON4dKlx7kroNUvUD0PSY
         dhPsKnuHZ6AdVlsyfj6LHw+ze7Q5XqtyQS4SOKnylrUyYQTfR+PLGkwmG6rxjDx6exyu
         ZwZujJC7b+Avy4kK9qyQa8JuNxoc+QD6kmw7q3W72HOQjhZFNmz+TWFzNTDMoJ+IvPJJ
         +z1QGg/01546kZ/e4Dmtv2oWzF4J0b2FRmq2P6G6qS4yq4+au9Kw4Xqb5Z4gPrPboHgu
         0xhrKw7nHTCFlQMll/EAtS+aHCRQ9IpSxLV/tcr2QpE53Ng3+VxTBEUpBbM040NDipkP
         0+xA==
X-Forwarded-Encrypted: i=1; AFNElJ+fHeWsCGSaZwfo1q1GuQUhMM0bBqVFZPvg1MSUheL/QnK8pRB+KvcqXZorZM3KSGj2HWTJBk4007Zeca1bNw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIGWMnhgxnDhyOdmwM0k92AYgUHkfaYKcoM9KD12TsiJxHE3Hn
	N+Nt709ZaIC6Ksj9foRWEqynZ2006sINuilAH7BRdOvTQmmuRgi3ePuABU1XZoNNN38=
X-Gm-Gg: AfdE7ck+GPU+1gu4hX7M59qVruWuI4FwryTfOBxjgw4cb4NiM7A4D8+Ai4Vu0A72Wik
	EQGlhgzEn/e93p3GM7dHPd4ZZXbtCweO0fBtS4kcAGCenaQ5nsy70lPczlQtyezDvtcpTqRv6gv
	5qMWXoPtPjsKKQI4QNbF5Cep/VqMs5bDfoQDoyoS11tW0nNHV8JDjSwYhcz/FC2l71BxzbZdPVx
	TWaJFDEcaewLR9KFsurSQUEvqovQ+gmNT4WtaeLnO1uv2uN6NQKXYQip2yeBRYVLEjHmKU2WSFk
	KjVzAWwspQCAyP4zEKoF/ucXRI5+c+vBAzoNbBhjo68vuQvr6UCcnG1e4KGfs7m+oh8R0zfpa+2
	R6A2W0cuttMXurmIeDPe4WxMg3MD8WrHzGoB+MaUvQ2DJb5kAdVBVICKEZoY6NUz9AvkGb8Urvl
	CuuMTaGYK9zpULvSE=
X-Received: by 2002:a5d:5f53:0:b0:460:6b12:1783 with SMTP id ffacd0b85a97d-46268e1fcc3mr4236952f8f.4.1781692653017;
        Wed, 17 Jun 2026 03:37:33 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0d4fsm57111382f8f.24.2026.06.17.03.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 03:37:32 -0700 (PDT)
Date: Wed, 17 Jun 2026 12:37:30 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Vlad Poenaru <vlad.wing@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Breno Leitao <leitao@debian.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH net] netpoll: run NAPI poll in softirq context to avoid
 rq->lock self-deadlock
Message-ID: <ajJ46o4fomfxY5CX@pathway.suse.cz>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
 <20260611191114.5bc43a59@kernel.org>
 <20260616103529.Yh9Dxsjp@linutronix.de>
 <20260616170257.GH49951@noisy.programming.kicks-ass.net>
 <20260616141719.67684bf0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616141719.67684bf0@kernel.org>

On Tue 2026-06-16 14:17:19, Jakub Kicinski wrote:
> On Tue, 16 Jun 2026 19:02:57 +0200 Peter Zijlstra wrote:
> > > So this is not an issue since commit 7eab73b18630e ("netconsole: convert
> > > to NBCON console infrastructure"). Because from here now on writes are
> > > deferred to the nbcon thread. So this purely about -stable in this case.  
> > 
> > Hmm, I thought netconsole had some reserved skbs and could to writes
> > 'atomic' like? That said, it was 2.6 era the last time I looked at
> > netconsole.
> 
> Yes, that part is fine. The problem is that netconsole tries
> to reap Tx completions if the Tx queue is full. We can't call
> skb destructor in irq context so we put the completed skbs on
> a queue and try to arm softirq to get to them later.
> Arming softirq causes a ksoftirq wake up.
> 
> We already skip the completion polling if we detect getting called
> from the same networking driver. It's best effort, anyway.
> Networking-side fix would be to toss another OR condition into
> the skip. But we don't have one that'd work cleanly :S

Alternative solution might be to offload the ksoftirq wake up
to an irq_work. It might make this part safe for the
console->write_atomic() call.

Well, my understanding is that there are more problems.
AFAIK, some drivers do not use an IRQ safe locking, see
https://lore.kernel.org/all/oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh/

Best Regards,
Petr
