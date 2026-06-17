Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1853DCDBD
	for <linux-rt-devel@lists.linux.dev>; Wed, 17 Jun 2026 10:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691135; cv=none; b=ufCdWlxFj/gXC9Xy2GczKKu9NhJtXx4+MqMQbarnkGJKr9Jm+Zu9aQomqODE2qnoZyKA71Xn4MI9EhnZQHbMLg1DunbAfoQwRL8XKD/CouowSzWAdYYebY1ClkZ1iMySP3PRpeFqgJM/Q2qfPkdLRC4Gtm7u5ASd0D2YRXhUpo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691135; c=relaxed/simple;
	bh=zqiyKisxnhy0xgzQCFdf1v6HFhpfFmktZ4vRlTJ1+Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+jMwu5kQfAcmd0XYhTNIsnrI7h/0qdMs1ZBQjfTg9fmEydl6HJaGmnGw2Ok/BmrAaBOFL0f9Y8Cxn53qM03xcf594ukAqAWf9SmI2Nchlp5RJWcYajNBT4uKK3Q83+6eyN6LPW2c5ZZmslcnfL+/ACQR8i33ZSSYopnuRspqUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gg4zf4d5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gg4zf4d5"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4923139e940so10027955e9.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 17 Jun 2026 03:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781691130; x=1782295930; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9e/QpG56/O5B7hSvy+0kATSJ4lRQbuxYrUIyg9GDMZQ=;
        b=gg4zf4d5h+GqFsaw7jKFxi90dULkkF4QhlLESFClEsu4Ke0dQYtZrDe/UJOns4LFxU
         0RV7/3oxAwqdQbgG7qzvt2qwfaZ4TgmmbKLGE6S93+3bAh62HJHtUOMlKycU9z7D5vB1
         TKOHbjkecl9MTQMCUF04jqrsGqAchyCqUDvomwlMFJHNgY3Vlx9jS/C0m7ZnQej+O9oM
         efXMrS6DEOqVjHLtbk1po9jsz0q0cpyejPhEkulnugTQOQci+Nxb8+Kk+4mvUUDz5pkX
         GQ3oJ9BAv+KLgVAaXIXUYRLSvAH8fouBH6BOziRr3zNpOEGYyrbyNRuttwSuwjxX5xxo
         aT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781691130; x=1782295930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9e/QpG56/O5B7hSvy+0kATSJ4lRQbuxYrUIyg9GDMZQ=;
        b=g/dABbfMjk5YwvR18tdHrtmUZJLKkUG1jdcSbmF9Va2CB4jeUIGNkWWpdezkb6eS2P
         S4/DBfpEKWYnorf5Bjw/g0F3+EBSMO8J7kZdtVH9718FZBABax4ee8MScPTiKm0w9CZz
         Di6QSJmxDnNKjNTpknAdsiwP55sGw88kwUzrqjqNso6Kn20gO8hpbLF7RgwgqrGg4FaU
         ygHupocR/76cWY4Go8i+WdXEGbxygK8zlRYxLqBbLyR3uKS1iwfCTW4cGkbANOTcTHkM
         xwYtmVeQQ+BLRYbUaCqSlpHd7//nyFzQIKtbrT7LGg2QVbL259jw22CA1cSIR7ciUWny
         97Ww==
X-Forwarded-Encrypted: i=1; AFNElJ9UgvON0Sg4OPuN/5a7eMe2oWWj9NVeo68RYzUV6dKcUNOnRyahBUeAFx8dmFsRXboOFOaloDLYbKANcuuh0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6076mEa0qp/l3RR2dxZQqZuZBkkT0YSLoWQH4z61LDVpdXpJ1
	De2hsk/Fk4WtjAoBSXaMMGnyafNqEf7+WWfQ28oUMvJU54/rgbo5fCrfmvFT4wWhDTk=
X-Gm-Gg: Acq92OEUN+G+JRHNOY+KDOnYDuDo4emoMVkC1+qipcjg57IYP2HZeEna8wVAUGyHi9Y
	3eqD4a0AREG9BwkvTEYQ+aMb9fSjjsgMFTuLG3s87jxVyxxpNiQecYHahvw45yc0Th5e47KDy20
	9C7Ea6Bma4K8ecK4WVOAYA7GQRp1ORjLmr8d6pFXmEW5zQmQbzK/pFu9fw32a6BTGC49lKnDgHT
	MDkI9CqQm7lfrTI3m+Mq3GlZLQ7GKJG5KGoPCbQaNVkgk7y5qO43fFdF2R2TwL3cAVqD09jq3lX
	HxLhP9Nvu0JjNuW9LLQe5nJHL0f4IPvYQfKnsgeaxj7Bxypjgl0Qwid5Lwda5lnPNbkspv8ImUI
	iUhnDPipGGip1T59FxuroPzcaD7zU7w/Q6tfGej8hSZY9zCUxxYC6eUWnCCmx9SeJRaXD6QPQDV
	yKni9NKNQoA+tkACc=
X-Received: by 2002:a05:600c:470d:b0:492:25a1:e2f9 with SMTP id 5b1f17b1804b1-49234131e65mr39184075e9.26.1781691129811;
        Wed, 17 Jun 2026 03:12:09 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923686fffcsm1799745e9.0.2026.06.17.03.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 03:12:09 -0700 (PDT)
Date: Wed, 17 Jun 2026 12:12:07 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <ajJy92ES-Q8ro97A@pathway.suse.cz>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
 <20260611191114.5bc43a59@kernel.org>
 <20260616103529.Yh9Dxsjp@linutronix.de>
 <20260616081128.04e2c8dd@kernel.org>
 <20260616153122.keHMKvVT@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616153122.keHMKvVT@linutronix.de>

On Tue 2026-06-16 17:31:22, Sebastian Andrzej Siewior wrote:
> On 2026-06-16 08:11:28 [-0700], Jakub Kicinski wrote:
> > > 
> > > Adding sched and printk folks for opinions while eyeballing
> > > WARN_ON_DEFERRED().
> > 
> > Thanks a lot for looking into this! To be clear - the printk_deferred /
> > WARN_DEFERRED would be just for stable? Or there's still some
> > sensitivity even with nbcon?
> 
> We already have printk_deferred(). WARN_DEFERRED() would be new. I
> *think* this is not limited netpoll/ netconsole but all console drivers
> not using CON_NBCON if the printk (via WARN) occurs with the rq held.
> I don't remember all the details but printk_deferred() was introduced to
> circumvent this until printk is fixed.

Just to make it clear. The problem with the legacy consoles is that
they are called under console_lock() which is a semaphore. And it
calls wake_up_process() in console_unlock() when there is another
waiter on the lock.

> Once we get rid of those legacy drivers and NBCON is the default we can
> get rid of printk_deferred() :)

Yup.

Best Regards,
Petr
