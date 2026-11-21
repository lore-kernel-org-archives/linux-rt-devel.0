Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795235731;
	b=t6VayA81ey7xjCvF0a6xkrG8gFyh7WVpZZnIpfsgQ2sNUYDj49xOb/G9ZhZ6wSldO3FS
	 9NE/6czRUNIncl4ISl1qfxpS+C7mzZWutZDB3Su6z/BnZ5FQ7GxCIOvXX1hZEaJAwBikX
	 CdsmCy52TANiNz4VuOTb0yc+ImHXo1XHanwXZrFg0OM1zAs+Z3zROnwvNSNZBbYFZM5lW
	 ZuWsV2IBhNeEV5LaxfEm5ECHhjUi0Ne63zb2i7kNKonHgdE9gmNJy4Z5bQzAwQjgT3TY7
	 ybJG6bY9o1uLqaSnW43fuUaPkL5GgLhQ1IHhawlent+sr5jeUXbbmvNvKgWcWZj5N5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795235731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9R6zaVIvtgH5jzl+qiEpRbTjV5svwtDU6V7VCAEyGSE=;
	b=mV54jPneI8Jdc4ZPyGOq7HVoGFWqnCjnPyr8vftcq9BmlqZlsk79fkIaCwU7oCT2cqKz
	 zACaSV4zXcya1s+5xK9yW20tTkFhywrvxFVFbfikBX8M0/Z7Tr4gKeDy/UKdLpHg4Gmwp
	 lxe47kL6f7fbefuYjBvBGcIb3DWPtMMegtcjHP492PNOoSLgEnfT9xMued7VyJK3vOpMM
	 ivfoURwR1aeDHCrCb00CG9dA25Bxd9GB+nKy6qmDKKnE+5jlq4aOipsrTRUbsJ477P1i3
	 kAEOlRZnKODTL/zb4YVmI32sF6ZufRMUmitsjhV9CYPIH/W1rIqrWVDBHbR8WNgI0cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CEFwH1UU;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EF460A2602
	for <linux-rt-devel@lists.linux.dev>; Sat, 21 Nov 2026 04:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86EF460A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CEFwH1UU
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48e47347279so878585f8f.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 20:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795235728; x=1795840528; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9R6zaVIvtgH5jzl+qiEpRbTjV5svwtDU6V7VCAEyGSE=;
        b=CEFwH1UUIVvVKA+BTrom3mQm0IpezKMBBBqnwP0aQqlnm/OAxb9XefbRqWxd1Ikdj3
         Z5XOaAEO4SddYPMAL/pwpFgUunZTyVuLLvRtGzrdzhvFSEe8ENC9zWOKrQN+hIP9ks7P
         b04/QgkZYb2lZ01tvMjt9ALm8slsONylDGt1oBK5/AAzP8rJuTY6layK0pkds3tpO1J8
         HaP2Cae5JP1hPJYuoG5AlHAOTrO5g6aLknWrXq9miXg0f0B9fLV4+AfEgKWOh4X9IIF0
         t/Q3P36Z2avXp6EqgsHHU6qyuz15Y3NNdTBc8/vFJJC6Ug5EKwu6R+1b56WG76fINt7D
         yDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795235728; x=1795840528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9R6zaVIvtgH5jzl+qiEpRbTjV5svwtDU6V7VCAEyGSE=;
        b=cgh87odaWsk4hOeDJg3prNNqiDg0XMKiw7TnLgk7zaAP5gb5G011CHf4zUqhy75vvg
         J1LNh7xaZqOve9Ad/M0FbCSCR4fqJkZ3QP3+wMekJ5vwqynLypRPBwY185ePqlzLvNDM
         sWdqxoiOaXUUiIrVty5DDNJPQkVhTl2ur7FSoOdWyworwuiuqYNYxc9mcRK1oqIymAKd
         apWXWAeinTg7f/YilJyltoxIC1NgcMxozDz1JvRLajVo8W9J4Be4F4vlD6PfMII8ZcEO
         txuPixM1qKw2v6t2D4TlUGR5tPb3Nb/BNt4xX7n5ygjQuGakdDoyGrRp2LFvRQ/c6tgi
         xDww==
X-Forwarded-Encrypted: i=1; AL+hErEKXVXupHf2SAsQfxnDK3cTnMDlHEfYJ2N1QowGMwK+qmPDa6wQL6e9l7OeNPCMDlkOGEPk0SpEwJ1p03rwOg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8vnvmKv0Ix897UeQgeGaL2T4FhQzSkW2Pn8t7MdoejFiUc8wqb
	/neJkuiJ4UxVQH0I+3Y0dFqnqPU/H7ne899pLeTqty7YOUn5ahpVHWFn
X-Gm-Gg: AZFdTZcWj2eAEX7PI+5CWdxqDbkDRQ8NhHUumqXUuo6y+0AZLXE/Yf19RnzSVPZCV0v
	6AJkhG4YiMfTBv/r9HN65qpXl1t70UXo9I2g9KHPcaol+8nrAKYA0B94XIDfuFThZhD819h1xuZ
	8dkXk8LqidstwiGUOZV7LBMHp4cGjQ0mZQaoOJPHw4gyZ7dnsMqxCc5+c55qIVmJhSICmP3dubQ
	fDAinh3jWyP4qUViurDto9rJmdu/tDQG9iaA/gmynOcI3yopjHd8hnpBKjQVDxQycC3ObsgQWZg
	WJjYiSxmq1+A2CyrKVt+KfdGDmIRqt1WogxhpM3CYcA1K0oQq3+k5DprYhkKzVh6sqIhX0TK1XL
	T4EZ7G1hxziqDaq+0YkeDXkh/0eD5i/01DBiR/iJWmLAPjC7QXaucklwkl7+q54DDQVPlwCnhaW
	xcuB30D0Y+R9c3WlRRwIjHANcnNPZ1pSAuCfetdVDawDThvpVkKD1BgPfIQpF0eULQxm9InZRcQ
	ni2Z56MXtxIIvn+FZhcEwSLDGLrod2YnlMk84QvzzqsZIflFu+W9+R3/oe7ZVk0AtpYcVVBxvS5
	Frfz1yNHlfe+sF6Z2LoqAOiLVdH14M9/3030bb21fbaiK9PAbt8QmMigm9EC2r0GOlQjrWP3PlS
	auplm1KitR4MDzUwQwP1xBkxtMSte6nzbEVbpDifFkMgjvWUewK4vu52jmTWZwPnR0mCtE49oL7
	iY36xixnFKNN4tNpb9JNVIg1fMgmjLAoh5
X-Received: by 2002:a05:600c:820d:b0:4bb:7b4d:6396 with SMTP id 5b1f17b1804b1-4bb887e21c6mr111271405e9.3.1795235727586;
        Fri, 20 Nov 2026 20:35:27 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-aeb0-6801-ad74-bca0-dc5f-7242.310.pool.telefonica.de. [2a02:3100:aeb0:6801:ad74:bca0:dc5f:7242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8526cbd0sm214023515e9.0.2026.11.20.20.35.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 20:35:27 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	David Hildenbrand <david@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	David Stevens <stevensd@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] locking, mm: Add atomic allocator trylocks on RT
Date: Sat, 21 Nov 2026 05:35:13 +0100
Message-Id: <20261121043513.20538-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261020152708.3atPlnSl@linutronix.de>
References: <20261005070625.8871-1-kmehltretter@gmail.com> <20261020152708.3atPlnSl@linutronix.de>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Oct 20, 2026 at 05:27:08PM +0200, Sebastian Andrzej Siewior wrote:
> What is it that you try to achieve and why. Why is !PREEMPT_RT not
> affected? Half of the problems origin from PI-boosst.
> Why has the nolock an rmutex-backed allocator.

The bug still reproduces on v7.4-rc3. 

GDB caught n->list_lock's unlock re-entering try_to_wake_up() under p->pi_lock.
kmalloc_nolock() uses normal SLUB locks. On RT they are rtmutex-backed, unlike
!RT.

> can_spin_trylock() skips hardirq and NMI. There is a trylock on the
> local_lock_t.
> Why do we have this mess and couldn't we avoid having it?

This was IRQ-disabled task context, so the check passed.

> I looked at the patches and there something about hardirq-atomic waiter.
> Wen don't have this. I don't think we want.

OK, I am dropping it.

I plan two patches: move range-tree allocation before arena->spinlock, then
restore the RT check that rejects non-preemptible callers. Does that sound like
the right split?

Thanks,
Karl
