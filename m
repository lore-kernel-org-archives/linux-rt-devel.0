Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281334;
	b=i+tUJgMvTwKSDWdGOaz6ohUdWCLqGH1o3/9D4o/XLudoJNYIRFsmQDPMfphvusdCP0BU
	 v75EG7hQ6L7tMZZM90/REebKlbV3F1m3P4hcDWzmi2p+xFwW1eondPEI7zVi81L7Dj+p/
	 xDav8HmLx8ey7A3CYlMlNW4bGZo7kOBC0Z5bpH8IagmWRbpsXcsgwVP+rCv4IH0RgrX83
	 32eB/2A/cJHXyqzvkKgmSzFkQEBGCbfS1VblFXWGRmPKFr4QFnkfCoHTzXyA19SO7iINp
	 sWVtQvzNzo8bO8UkkALajCRgLvXu2lg29a6DXHdOuaBr6RL/Y3T35s4GOG8Hd8vFD3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281334;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=O6CTOI7Goyf3DK/jXbQM9sZjnDLqWtwiiqPhDSY8VTs=;
	b=Rxk4hBTmoLzKs2mBtGAvvpZyfE9+dww8OpRYMIFQDSChtqQ+fz8pv2SSAcnvdP+Zx+s+
	 /Mrhmq7Fprvhggmi2Ur/ue/fIMBiurXVQI1yG4rABJWqVv3uFXjGUpvAJTcmU01u1QHMm
	 1X/z40cEu9SW13xwO3egYCZTa5OUss8MmGPdH4IT+C0Mc9OrDySiPOJO99slMc3LPifz8
	 ilIDZ+JglIavZpDaoNGaaqhfPJqQn70QD8Yy+MT6T/DTmbhEfGWbjTSoLErhL0Ym8AXOK
	 EB/RQVjko721zDkWu0/YiceaWyMp0LWFpCf/DDkK2XUhdk4yqC2oiXgQ/A1FvBtNJ/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qpIOkpVT;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470B2606A322
	for <linux-rt-devel@lists.linux.dev>; Thu, 29 Oct 2026 13:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 470B2606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qpIOkpVT
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-18cdcfc05ffso2896899c88.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 29 Oct 2026 06:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793281332; x=1793886132; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O6CTOI7Goyf3DK/jXbQM9sZjnDLqWtwiiqPhDSY8VTs=;
        b=qpIOkpVTfDSVP4MydYKiB2Yv+XYAu65OEtHGic6cAJbdikZNf0Xnejqn8V7H2rjmAU
         /9/q8Yrn9kgySmezkwwXt1YmnIYiU7AUPxos4fQfq7qiQriIHoM7I3iEmrcbEsPPNpSJ
         LBzyfx2xX3VAn1vtUCexVN0Dvovs4HQTs/VMUC4MQfJe9JLsT7n8d1aGnluvYAD7IBGs
         g9lMG0LocLmGvp3ZWvMq2VJWoR5YtIl60HS7qqnQ7oPX6Bvgbq8wbr2mcuvBlCrv5SIx
         X4zbaotfCcDovRzHdY1goTcv3A45zaazzTeEsaeD1oVE0IY/jTE8GF/DNcf2g4a+Hv3f
         vBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793281332; x=1793886132;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O6CTOI7Goyf3DK/jXbQM9sZjnDLqWtwiiqPhDSY8VTs=;
        b=NFGsX0IQExWU+R7dPS03YSpS64kZQ3Ofx5RYQd/gnpBkNoHnQjxeePOqvZh5rn+vtR
         qkJK1EPq4HYrTTuFhgNaEmR+Kk6nshu3wpDAoZnMhUGv1RZFBraJJsJTvCh9XLeAHPvg
         qoxjG0bl+2KOxiYSSFZWLSmfOoMBBrraKMH8DSQFrkj7/iDiwf4mK7VEjdJbcQ9kfySa
         d2Lfig7tzM4JJRZ6gAf+ydCIlBhWRQRXKkVYszKuDmwzu8yePvfnGji0jEh+u6R8qBMV
         fhXo6Xwd+woEG8yFKaMA1Oaal/RYdKlXys3w+pn9HXkk1Kc2jOxvJkY8xPWdFpGCsE9R
         WxfQ==
X-Forwarded-Encrypted: i=1; AKwUvBx7lr8wUkB2QZWJ9PdXBrncP5dUb3nASXi4GNBPKWIDODKP7ulYzGP1BNhz7WmUeegSJslEtWmFKNZO5hXRAQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYK439rIPQA8V41jtu9MyLQv1sbT5klLzhF5KETS7ZGRPoNzkPoQ
	jTQIChRfeT5k6PNDs28kY8gy0k/9Og/o/A6Glo7nIUpSt81D7LNrNspOXWi6AZNkBi4=
X-Gm-Gg: AYBFou2+SvSjrWqHoGw3//PC8RCThm+6qiEx+Z4FnjKV3A7dGI9w+GcQdQFwwvBbo/i
	TN5HW1vwKvxk4BB78I3b3taugMmnw3DIxNmXyRH8ZBb4c035KdFKMrSCsBhivY7VczASDt8omP/
	TCMVX6tdKy1hCllU5a2lipmA3SXHj2Vxq6mbAFzapZuYNSRWTNHYiwxZaMEtSc5OCDfMwGsYYGK
	XLC5FmcY4v0Y3cJ/hpsEj+ShYrcRrHwy+biLJ3Mz8e/Rt7+YM4G4wSM5A70USYu7QDMzgNdzrUU
	CcCJxoopLTH+q6cYSmMvNqfsKxIRZXpbL+zdnKi547NI/fhZ/cIjcKByMFmLj4N+TuXAV5MlhdO
	mZTaSIAzUOOnniZ3ug+07TUZPV3nV3CW/CdO6rxIK3HDKoaWMF0yHYu7gyelBpyLUhi5Sd/LO1G
	cvLskauorJqChJmQYdKWhAHGy2/82uiBSu+FeQbg+PFBGyv0SFxyA8b2YN7h4I8PXs3YnlBq+Ag
	9acNBsc6z7D4orS/HCeY6u7Lf55daWF+KNYK3JG0QTKL5gfq2tnFKWG1o+oFwMtYAiEZ7c3R0RW
	d3VlJj82Tib6cnIF7txS9hiJYk4t6IBz7aL4+RHaMD5rBphQkV7t/Dz+0KpU4cCb5V9392/9fGw
	XeYylZPtyvkbq
X-Received: by 2002:a05:701b:4201:10b0:1a3:8d5f:6f93 with SMTP id a92af1059eb24-1a6cced6334mr7561828c88.17.1793281332099;
        Thu, 29 Oct 2026 06:42:12 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75e1f2de2sm14760120c88.13.2026.10.29.06.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 06:42:10 -0700 (PDT)
Message-ID: <502f31ed-dd70-469c-b433-577ccee36c3f@kernel.dk>
Date: Thu, 29 Oct 2026 07:42:09 -0600
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/napi: fix list use-after-free on PREEMPT_RT
To: Anvik Loitongbam <permissiontogallop@gmail.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
 Olivier Langlois <olivier@trillion01.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 stable@vger.kernel.org
References: <20261029102244.141621-1-permissiontogallop@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261029102244.141621-1-permissiontogallop@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/26 4:22 AM, Anvik Loitongbam wrote:
> Commit 45b3941d09d1 ("io_uring/napi: fix io_napi_entry RCU accesses")
> converted the NAPI list teardown to list_for_each_entry() and
> kfree_rcu(), with a comment claiming that list_for_each_entry_safe()
> is not necessary because kfree_rcu() defers the free to the next
> quiescent state.
> 
> This assumption only holds while the surrounding spinlock section is
> non-preemptible. On PREEMPT_RT, spinlock_t is an rtmutex and the task
> can be preempted while holding ctx->napi_lock. The raw lock inside
> kfree_rcu() only defers the preemption until it is released, and the
> release still happens before the iterator advances. Once the task is
> switched out, the context switch is an RCU quiescent state, if the
> preemption lasts long enough for the batch to be flushed and a grace
> period to complete, the callback frees the entry, and the iterator
> then reads e->list.next from freed memory. The same pattern exists
> in io_napi_free(). I did try to produce a uaf on an rt kernel
> build, but it did not work.
> 
> All list mutators are serialized by ctx->napi_lock, so the entry after
> the current one cannot be freed before its own iteration. Caching it
> first with list_for_each_entry_safe() in both loops might be a more
> safer and correct approach.

I don't think your analysis is fully correct. On PREEMPT_RT, spin_lock()
should still be an RCU read side critical section. __rt_spin_lock()
calls rcu_read_lock() after taking the rtmutex, and then
rt_spin_unlock() drops it at the end. There's even a comment on
kfree_rcu() callbacks in there too, it should not be able to run until
napi_lock is released, which is post the loop.

IOW, I think this patch is unnecessary - there's no bug there. The list
safe change could be done as a cleanup, but it's not a fix.

-- 
Jens Axboe
