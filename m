Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794018736;
	b=j8ZjlXHzrOR8ZZsiMijgF1YehzkFH8xgoYpCeep0BhzCBSR/OGK6bSX1DeFvxOUrc/fE
	 3e2rHzJ+7HA2BUuNZ6ErYHAkE2RXT4g1C9RXcvD6iWZteKcdhPOWhON5sF+qgsHPdecAF
	 CNYRSYkOn2EqaLUSFVfsKZcZXWu0RM1FQyG7TZ8OpgvQWqjQfPfKtEEAa4Q4Kh9QPxju1
	 2C25lKNDfQFToM3gQn+Lc5ZScbX6nIa5jk/Xfk0aGvRwr025B+e657HZV22A0X4ZAIbqk
	 Vg6Vsc/EebDv3HJW2LJ8KwmT0zHIpIz+NqDtvMMTkmEbCJ6Bggb4GyRZYhFajWSj9eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794018736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=HVvkxN+Yu9GQpNIywW+xYkVpi0gO8eGj7Vx/EPDvNeE=;
	b=kHbF7iUbps5hOgfp2/PAaQqxaCkaDGcANh5HAvMileHQE3UZtkfn1sRsgoVKwkEHo07z
	 FJbwzUb+/reoF5KNFzyP1BGqmWu7VhiVwt0NyNA78e8h/GokWKIHIV3LjQOxiGdZG3daW
	 5uYjqYJIu2fesV3so2OBlkiyY/CZmcBRNhPYpwQqJWiQV+zmcuNCUGvaXFZvGg2x7+KTp
	 vLjMzDfaRSmF5dbtKdFiJvS1ULAt+4HLVh4yO5x0wy+i+aZlFt+qyN/RfnLGPHFFib/wE
	 5qMZNIQs3QXYpS9k7CalN69yn0beBbDal90Z5hrNsjyW8zovi/TIfrWnUU81TV1SwHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=layalina.io;
	spf=pass smtp.mailfrom=layalina.io;
	dkim=pass header.d=layalina-io.20260707.gappssmtp.com header.i=@layalina-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nU1HoFwQ;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B960606A32D
	for <linux-rt-devel@lists.linux.dev>; Sat,  7 Nov 2026 02:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B960606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=layalina-io.20260707.gappssmtp.com header.i=@layalina-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nU1HoFwQ
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso7859415e9.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 06 Nov 2026 18:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20260707.gappssmtp.com; s=20260707; t=1794018733; x=1794623533; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HVvkxN+Yu9GQpNIywW+xYkVpi0gO8eGj7Vx/EPDvNeE=;
        b=nU1HoFwQ1x/5kpqkmHyIgf43PYr1pReHlbJL9ssHTWEadVV+RWNdyX7mjFCQv1riDG
         uvB2O8xHm7swDOkxB5M4vHyVVb6ssxHOH6H1sKYE4zoQLLG7vc0d95xbHodQ5Vu5uTNG
         cvri6mld7Y6jH7fZkOch7+kKftK4hrm/SVOg2uKOsyGcHokx1SsytShy6mvZzNPAMwt/
         bUrl6LYHuQK6ef5j02jrFUxd8IsTLp+HXOU6G923Czx/fHBQdIlGGqVf9fLQyG256pJK
         x83TeYfxmOP6/hhEDjbpbM4dW+p7jVhpEDUazOxtrobV9tzAybP93rr1ngici4GdfFx7
         92pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794018733; x=1794623533;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HVvkxN+Yu9GQpNIywW+xYkVpi0gO8eGj7Vx/EPDvNeE=;
        b=KVGbYrHaffV6RxIoQUZkvUasLrXjyrfZRLq/rs/Aio8MBkdSp+ugxdsvJ4pNCZnWNl
         t28XfwNMSEbTJ/u888CvNHnjA3ZCAEzAmAt4zm8dxx7PkFwE9kqlcBoOfCGSBQX9pgbv
         BInEGMOa58XUBzJjAmGimqr6s6J2FzBXkqXvoa6YtvpIyq1Ef20A02jm5M+CbnxWSRvK
         QKdeSmOaBCjF2SCcLC4TZS/Jzchszj40trwnvALqgyGu1t/zLa8DY0M+ZhUV7sda5oTy
         itS1G0+5wWgNJhxZy8Jt/BUqK5wX7jCf1u+IFnD1oH9zIQM9p7138IcRCbch+sbCndQS
         Zybg==
X-Forwarded-Encrypted: i=1; AKwUvBy0Xs4K3TvoOlnKYtlpoL1BYWmrlkb2SPkF42lU9FKhV0A0owtM+3yJYd3e0vccYYmxU6uvJvdGJGTjE/KroA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/AnVEnG7VNLeKJShtC+32UPQBIWYbj9sY2Nq1PBBOfPBXyVUjO
	8klluzjNQyUlIdiPTO1cy3IYleNLYPo/RkOPSi0cDNwa+SQXfBC2ggpMBFlJWGZxI1A=
X-Gm-Gg: AYBFou2jDgoc/iqeF2XYRnBX3fJy3QPXZBkeahqcfQRY8PcckKUztCI+x71oChFeKsl
	bO5wPq9+sDklvqNsC5JNEd7kMkg/TgBbXCnE+bWM+JsSp7i/L3UW73Doy30ldvqVVQnqS25bwYU
	5+zQmdxov/4gLWhjxjsA9fx8ypIizDZjhIzGH4eaOcJNQtNrmlvcn9yEMFRR1euJ7TA8BhbP7H5
	ntuH01QbUL0s5GGcvSHnpqsoaeCYQogl17cZQyKbyd3+oJQmc3/YbExG0fczW4kTA8APc6ZGWQT
	kA5pDkX9timRcWpKNcS8o0+I1YNG2t6bNKZvAyP5BVpXvYYUDR0H0UdP6TaTSeptpL1d094aisO
	4yfx5EXB9XHH+zUVeH3/7PTOaHI9kxiNROl0uhS95PPBQkxR1SfHyYwAIdxtCr4kLIWlkr9jp8G
	K+A0AiR1hjTwAfOqtetXmDhKQWNYNnbwRclhuIUnC0M46s09C+oHGU8zJmSDeiyi+YRu/87EgFy
	quBiPJU+b2PZ3tONVVIBB9EyEFq1ANNBRP+Dwqx7XEoT8OWeqvXkR3HPLqjTKiXmjWQqTObBw2b
	B21qVwZZldAxWIp2/iqmptx96kIe+cjnyLnpP+RhkJyOZpALnvPhspVyWRYhyEC7hkjft5EvMBk
	V8Q==
X-Received: by 2002:a05:600c:8712:b0:4b1:4017:c4f4 with SMTP id 5b1f17b1804b1-4b6df7d4a3dmr72659115e9.20.1794018733064;
        Fri, 06 Nov 2026 18:32:13 -0800 (PST)
Received: from aerith (host86-128-182-179.range86-128.btcentralplus.com. [86.128.182.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b76cbdb9cdsm33903415e9.1.2026.11.06.18.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:32:12 -0800 (PST)
Date: Sat, 7 Nov 2026 02:32:07 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, 
	linux-rt-devel@lists.linux.dev, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	John Ogness <john.ogness@linutronix.de>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	luca abeni <luca.abeni@santannapisa.it>, Yuri Andriaccio <yurand2000@gmail.com>, 
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: Re: [PATCH] sched: Remove CONFIG_RT_GROUP_SCHED
Message-ID: <au6Ln7JYI1lZll3A@aerith>
References: <20261106112454.GI1779021@noisy.programming.kicks-ass.net>
 <20261106113011.B7YxCMJS@linutronix.de>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261106113011.B7YxCMJS@linutronix.de>

On 11/06/26 12:30, Sebastian Andrzej Siewior wrote:
> On 2026-11-06 12:24:54 [+0100], Peter Zijlstra wrote:
> > We can try marking it broken; see who screams this time ;-)
> 
> okay. Let me try that then. Which reminds me of something…

FWIW I am trying to fix another broken piece due to RT throttling [1] and have
been hitting a wall on how to get my systemd to mount cgroup v1 to run a test
but no luck so far. I'd love for this to be deleted too :-)

For the whole deletion:

Pointless-Acked-By: Qais Yousef <qyousef@layalina.io>

[1] https://lore.kernel.org/all/20261103005953.56271-1-qyousef@layalina.io/
