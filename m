Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479364;
	b=qh093w61yvtOeGfXvN+eNDijdaphIi3FyviVPRb0nipyBxlq7jhuwgg5caQLmLWyqx8Q
	 bLG+8v6ADkrscYUMDPpS9fUhYfTNy5N0qnwA7lz614edu8jU/xfd+Nxl3r114R2sKYApx
	 bpQ3SA/96knmaYRPHUF5wsrUkYg0nEuBSuQUP2J4LsFFDhC4tP3R0NhhehnS41olo3pgW
	 L4Qu/jNt16ppSyyetfFyt9CNzJMPjYy/NBQa3kEcFzDhOHDMPjVwZ64fqRGzu2XIFZd2q
	 VgBSbQo6PRz0x+rD00kC4eSe5K7q+WN7G9myCjfMEWlhgMee2ljm6oz/S24DEYTlfag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479364;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=6vncnhn6Q/3wKntfoEarDeUgzDpwaWPokLtUTZ7KM7E=;
	b=U+HS5Jn28ccDeUPc+mcv++UwTnstbqfHVgBFzzU0hZlm1dxDvymVU+cP1cP8Bqlicira
	 zfhk7hvZaVcAwKK/JVpXDP2eBTZ2znnCRvxWnt2tiZJLl9isqsrPS8LAMgtUL6KyaHP9m
	 CK0kC2zspAN3xx7LVnDSwrfInj08RSdeOByTeYdOGP4WYewFEBDQI2L4jKayv/P4TuWeP
	 dgH0i1YZy4NIs2UBkua9BseJ1p2eWN9CI4Ucy3iPdHw1KSqYSkEGjDbjouFgvfqxU7lLV
	 I2QCPs/vEyFiePsyNdeCDuD/vZU/1fZknDNTnB7dTRksq6n11OPiY/SAs3Nq7oGmm6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g0cDVKdj;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B86606A323
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 10:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24B86606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g0cDVKdj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794479363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6vncnhn6Q/3wKntfoEarDeUgzDpwaWPokLtUTZ7KM7E=;
	b=g0cDVKdjm5nVo+7iRxNAHgb8XWsS7fzTJF0kFL3gdUaGH77ToAYZMwF3tpKsKq0rhusUMj
	H/niFxVT8WVdIACvXTorHeSCMt4Ssg0b2DRYr+TLW+VbWMxItFFd+e7zRLj4inGLLvK00s
	miZQxuZPvgMDhyvk974ZZ6D3T72MxpQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-L5DUS7OFNTGg4r4UmNJiJQ-1; Thu, 12 Nov 2026 05:29:21 -0500
X-MC-Unique: L5DUS7OFNTGg4r4UmNJiJQ-1
X-Mimecast-MFC-AGG-ID: L5DUS7OFNTGg4r4UmNJiJQ_1794479360
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-49166c8a60dso2952342f8f.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 02:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794479360; x=1795084160;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6vncnhn6Q/3wKntfoEarDeUgzDpwaWPokLtUTZ7KM7E=;
        b=hBg8FIzjJmuByrtQpjvEgVJbAIHg451IKqSHi25KYH1UzwsDKnX+r/caU3vemz2nmv
         NfR6qAp/g5y8SImImd3fakn5Izbf13VWF7BQzZCBqhcv3Eif5sYafqvIcqI1ECFAJLaD
         s62Xbf3fJCTzRG4GXA3OSv2ZVoAcjExFCzMSvSUcnTsLDkmJnscKZFGnLSgiHHXdNRC7
         KDJgbY9qTjUX1+SfPFJSJJ1+yLeFjOmNh+kruFUSwwK1P7OKp/TUeDWyP6x7uH80x5tv
         UTve3f0V8yWhIgnT6N8T1uhXOBug0aKxH6OcsP0pYLnzU7lfPISBFHZhA3gdcwjTIaTv
         dMvw==
X-Forwarded-Encrypted: i=1; AL+hErGlHF4fetrxMbGg+S9UymfMZd2tAXLa6YvBLv+NcQn4Yz78ekZG4xQ6IQwE9Rsev64jRyFGUFKK/8jheX8GTg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/7n2bECjrtlc+BTq3KYnffxR4zzTOT0v14dV86OZifwckWvXc/
	O9fm6WUr/sqOQNwThvt9Ye5S5jybBydFExmLG/30f0dkypQO7jtmVG3DHx3juyuRJecg0zzH91I
	wsX4rINegCUT6WdYrXynJu+QiItr8djghdEVEy12Od1i6lzu4Vs/3C32RlESPAf3IySyJ
X-Gm-Gg: AYBFou0n2Ep30YGKLswu5sV94YbIiwgiwIUVpX9n7mz1L2hpC6uKw7iMmuvcZyvoScc
	1GXFrCDqxnOspk/2Ssceo+cQBB0gNO4pRhY2eG+WANl3g0MttdGbz4d6A2pmvI1Kh2V12ooO1MB
	p6qIqIc1aziLrYTdhdmUcFEiq2m35kiWfGxu6SQb9bz4n86ubcMHOWIsACoF0E1aFV8+mEIvBev
	h30OxTmNMs9+5UiGXpNXzZXvyHaB7nXo/vR+ljvakRuGk4+GKf14H4fg02Ab6igX0ofApz5lhW2
	mNPx/fL5VKu9fWjiL6RrQlDm0empAq17zbLu0ojpLWEu7d6I8fxm1G30JY7JZxxnJeB/Q7s9H62
	7r1QOmOHuVnHZNf5mB9rKWO349RlsP5i25TYs/olFvS3tyaAqmiAuzfD172xz9RQ2eJqrU9pxU7
	GhZh8=
X-Received: by 2002:a05:6000:3107:b0:48b:d9:cb52 with SMTP id ffacd0b85a97d-499c7b1c5b9mr11631299f8f.27.1794479360298;
        Thu, 12 Nov 2026 02:29:20 -0800 (PST)
X-Received: by 2002:a05:6000:3107:b0:48b:d9:cb52 with SMTP id ffacd0b85a97d-499c7b1c5b9mr11631254f8f.27.1794479359967;
        Thu, 12 Nov 2026 02:29:19 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49bad3cd31dsm1615895f8f.56.2026.11.12.02.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 02:29:19 -0800 (PST)
Date: Thu, 12 Nov 2026 11:29:16 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, tglx@kernel.org, will@kernel.org,
	boqun@kernel.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	kprateek.nayak@amd.com, luca.abeni@santannapisa.it,
	mathieu.poirier@linaro.org, longman@redhat.com,
	ridong.chen@linux.dev, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, shuah@kernel.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, parri.andrea@gmail.com,
	m.szyprowski@samsung.com, kayracizmeci@gmail.com,
	weihengqiuu@gmail.com, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 25/29] sched/deadline: Count the bandwidth a boosted
 task is given
Message-ID: <avWU_Gh3cw-8y_9Z@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-26-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261108185406.1549770-26-mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -bFIGU2xeWImISLHnDFAJlMoaAbvBblZYuwIxLBKbb0_1794479360
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 08/11/26 13:54, Mathieu Desnoyers wrote:
> sched_setattr(SCHED_DEADLINE) on a sleeping task that priority
> inheritance boosted into the class leaves the new bandwidth out of
> this_bw. switched_to_dl() does not run, since the task is in the class
> already. sched_dl_overflow() changes this_bw only for a task of the
> deadline policy. When the task wakes up, __add_running_bw() warns:
> 
> 	WARN_ON_ONCE(dl_rq->running_bw > dl_rq->this_bw);
> 
> When the task leaves the runqueue, this_bw would stay short by that
> bandwidth, and skew GRUB reclaiming on that CPU.
> 
> Fix this by changing this_bw in __setparam_dl(), which every task that
> gains deadline parameters goes through. If no runqueue counts the
> bandwidth of the task, dl_change_utilization() now adds the new one. It
> now also runs when the bandwidth does not change. It then returns early,
> so that a sleeping task keeps its running_bw and its inactive timer.
> 
> A sugov kthread given a reservation of its own now has its bandwidth
> counted in this_bw. It reaches dl_change_utilization(), so the
> WARN_ON_ONCE() for SCHED_FLAG_SUGOV there goes. sched_dl_overflow()
> returned early for an unchanged bandwidth, even if no root domain counts
> it. That is the case for such a kthread, and for a task that a rebuild
> left out. Admit such a bandwidth as new. Without room, that fails with
> EBUSY. The Sashiko AI review of the third posting found this early
> return.
> 
> A reproducer shows the warning, and this_bw unchanged by the change.
> With this patch, this_bw takes the new bandwidth, and nothing warns.
> 
> Fixes: 8fd27231c330 ("sched/deadline: Track the "total rq utilization" too")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

BTW, the whole sugov thing still remains an hack, but at least after
this it has less chances to break admission control etc. Bah, something
else to maybe keep in mind for the future.

Thanks,
Juri

