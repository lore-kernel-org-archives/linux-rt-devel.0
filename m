Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F072D7D30
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Feb 2026 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771318486; cv=none; b=RRdjRQLJyMEwpPy5AGZqn4fIvZdTIfu59HkJ8FziP79UvLjVityJjNQb9ki9EUiGq+v1mJBpkAElrueYyIXEGs/78WCqMPxwmE0QOTcLAeOQGtcsRcR5jUCM6Rf9BKnrxg9DxEgIUtMBabHGqKfhglvzw6mFSQ+lKoDw7ia0GYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771318486; c=relaxed/simple;
	bh=U/y+F5lXzT6ipnlHOpj1gEg9m7Car22XHVLh0x06TMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wos/kNIJB0sY8X7EwAg5BERxYEi4mfFYK0pB2G2X10ra5WHqmGi+9gfubiHSXgEkrhNb1jvk73tR0XPmVxPwRQQueRq9GCj2oCsW9Jizr6vDahfUqpoUU9ROURuBxepWEPRMS2VGr/R3OaFStoXDn+o0ZMxu9137+C5zMN5hlqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MJ3KKg/7; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MJ3KKg/7"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43591b55727so4465034f8f.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 17 Feb 2026 00:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771318484; x=1771923284; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hjMcRNdBXILoAJvk/EWdE0yoDcwaUF03VAGg5Yay6bE=;
        b=MJ3KKg/74jdiw8YfPeWNPhrnXM5Iq9/WkNcEh4FLW9Ua3vdBH5sJD4tUxDuolVBC/C
         0YgmgbbIqV0kuQrF8aXEOvj9EPlS8VpubIXzyOW9Fb4mPnrMxjuBCdbCQnOQhWeKO9Gq
         FPzD2jKOnoCcv4T+UFevgggBx7JtHmBHJku9q1D4doxLgal79bxct61GwnqIb5c4sPzX
         MVvkVgYUt3mRFONAEM7RsJCCedHgM6jHuB8pPg/5ApqTsoELabn6FqALku2bnoAiazkA
         kJtGNYBsAUO6qyaVd0bO1cnUTj7d9xCAL0Q3Be+GcSvSwmBgiolAfFJ8/rIlEWMdyaE/
         I49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771318484; x=1771923284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjMcRNdBXILoAJvk/EWdE0yoDcwaUF03VAGg5Yay6bE=;
        b=Eg/tXoeds+wRUhWaq1j245GBZjdZl9w4D3UvLLLaEsI/ZLEQWzXDdP0uwKmCbaRq4f
         0KnQ++o3MGRnIQRtpq8+Hn5+YIu+xdmIoafmcPlWI9fJElr5xEuH4UfU4g/3KtZzJcj/
         GbsBEqfIOPQkx1L0U8dz3lx5vdlt3wrtTlFg90GADh5uMhJbJyVWIYjENRPi+xZRYdLw
         g+yKq29a8FZxJJ5Wrc59vJ6238MokTaebv1uKaOqsmeJV8VxAQoVZrzcdZkE3XmYa3ca
         OYPlsSTWq7CCUFKhQoVULXxrINjMW4077bHhJ9oKoAY2cM4MvLiEQjCOiCkvNMCocNDA
         VnSw==
X-Forwarded-Encrypted: i=1; AJvYcCXIjLqAb5BDlQTvSmqM0DZrOXM3ON47+TLq+YiPg68qNCJdzgd21qTDIFOep2S9S99QqR86Ul2XjVFz4EIz9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/PRLPtQmgOT3cb11cEf6B6V/9PJG7Jmo/sMscAPMkZN/+Ybaf
	c68Vxsh3tpPuqtWWCQcA3de2VQxtKuSof2RIt0VbiV4azeQQdF95cNf/i31QoxYyFe0=
X-Gm-Gg: AZuq6aL1zGcVwP9mHKvLCgh3dR0Prr8A7N+m4nYmAQ39J5MJjIBw9eyUhcjs82AGEeL
	dyMTOZ0V+b2jg/bKujqj3yZLOd/yzmtLDzPeyqM4dGJMUAava+ZzEDgSXNVSRiGs9nFc+fn6c5X
	Mwpnd8BGoW9RVajf1HEQ7sZEnM/pANmMwhg45Ka0+8lEV4LYhPJ5e+oizf6XvL2W4WoOFlyJO7W
	0yRRme0JeKIrM3PelfHpaL8caR6q6isKzVje4zyamElCnaiC2iA39CuSecf22JggUqNgpoEGUbp
	Pss49wAdVucPGuaE0Fd8eyfVbGNG7WxFz/ktSOUNz2eU3N1O/VdKHVriUN/Lti99qsHuKMqAmiy
	UVWpsUWRa2KysUISR2SvHBUdHSuF4VApCiKQ4zX1TX82VY1Npw3suoS+UD6ihMC1nJ0iAhWy15/
	2TPzMrs5+iDEJYjB+hBFVt6fC83A==
X-Received: by 2002:a5d:5850:0:b0:437:8f37:882 with SMTP id ffacd0b85a97d-4379db93a97mr20414374f8f.33.1771318483803;
        Tue, 17 Feb 2026 00:54:43 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abd793sm32552682f8f.25.2026.02.17.00.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 00:54:43 -0800 (PST)
Date: Tue, 17 Feb 2026 09:54:41 +0100
From: Petr Mladek <pmladek@suse.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nicolas Pitre <npitre@baylibre.com>,
	Calixte Pernot <calixte.pernot@grenoble-inp.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: printk, vt: sleep from invalid context bug
Message-ID: <aZQs0WYk262ZNybc@pathway.suse.cz>
References: <87v7fwdsln.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7fwdsln.fsf@yellow.woof>

On Tue 2026-02-17 09:14:12, Nam Cao wrote:
> Hi,
> 
> Since commit 1bc9a28f076f ("printk: Use console_flush_one_record for
> legacy printer kthread"), I see this warning:
> 
> BUG: sleeping function called from invalid context at kernel/printk/printk.c:3431
> in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 14, name: pr/legacy
> preempt_count: 0, expected: 0
> RCU nest depth: 1, expected: 0
> 4 locks held by pr/legacy/14:
>  #0: ffffffff807dcdf0 (console_lock){+.+.}-{0:0}, at: legacy_kthread_func+0x40/0x114
>  #1: ffffffff807dce30 (console_srcu){....}-{0:0}, at: console_flush_one_record+0x0/0x3c8
>  #2: ffffffff8083af88 (printing_lock){+.+.}-{3:3}, at: vt_console_print+0x48/0x330
>  #3: ffffffff807df2e8 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x24/0x138
> CPU: 0 UID: 0 PID: 14 Comm: pr/legacy Not tainted 6.19.0-rvvm-09292-g7449f86bafcd #79 PREEMPT_RT 
> Hardware name: RVVM v0.7-git-g8c45ccf (DT)
> Call Trace:
>     walk_stackframe+0x0/0x80
>     dump_stack_lvl+0x4e/0x74
>     rt_spin_trylock+0x9e/0x138
>     __might_resched+0x19e/0x1e0
>     fbcon_redraw+0x74/0x1a0
>     fbcon_scroll+0xf2/0x13c
>     con_scroll+0x122/0x188
>     lf+0x6a/0x74
>     vt_console_print+0x2ac/0x330
>     console_flush_one_record+0x208/0x3c8
>     console_flush_one_record+0x3c4/0x3c8
>     kthread+0xc6/0x100
>     legacy_kthread_func+0x4c/0x114
>     prio_changed_stop+0xc/0x10
>     kthread+0xc6/0x100
>     ret_from_fork_kernel_asm+0x12/0x18
>     ret_from_fork_kernel+0xe/0x3fc
>     rt_spin_unlock+0x56/0x128
>     kthread_affine_node+0x88/0x8c
>     ret_from_fork_kernel_asm+0x12/0x18
> 
> If I understand it correctly, vt_console_print() grabs the spin lock
> "printing_lock", and then calls fbcon_redraw() which does
> console_conditional_schedule(), triggering the warning.

Sebastian has recently sent a patch which should remove the
cond_resched(), see
https://lore.kernel.org/all/20260126180836.SNCdMW2f@linutronix.de

It seems that the patch has made it upstream in this merge window
for 7.0, see the commit 8e9bf8b9e8c0 ("printk, vt, fbcon: Remove
console_conditional_schedule()").

Best Regards,
Petr

