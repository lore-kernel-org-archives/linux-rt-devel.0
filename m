Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1674534B3
	for <linux-rt-devel@lists.linux.dev>; Wed,  8 Jul 2026 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519225; cv=none; b=E8AYGp73edFmSvJYRZKHrWhNzsScqkgiPYnJ4Hh6TIthaxTn0sNEDePtALhqfZtxPHiGXrzHss5uGxiLUgfGafN+5LvDFJwYPw65v00rYWATzvRZE/yUKuy4GDTUhMm7JTxA2XASwyC7O6+GjqNIgKjmu3oED6jFrNJxQXG7NB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519225; c=relaxed/simple;
	bh=+MyyKOo8bICk/aJFc/E236U1cUIY6gKGxNFTDl8Ow44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M99dYnEFncqoM3scAFiqQBqupWdkAtJFd1qM4H7s9mxj1Hogq/zZdZmkxLIT7dEF4V8Px2Cxz2mmCkNa1PmDJ7zqIqrn323uI/ygWwbd4RWWH7q73JxF0ajQIxNCm1x9JHKk7ufjj3Jli7nTm7u2MKf5BvTpiTmM1x7zv8O+e4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=evFOCRxc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="evFOCRxc"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493ba701891so5081165e9.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 08 Jul 2026 07:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783519222; x=1784124022; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gyOhrDiD3HZi1C97C5b5wI4tA2tqQIhwOgRgckqnDRQ=;
        b=evFOCRxciQSH1Lo0gVVOWVVvu1maZO0NciCpU/WN9Fg2VbkcrXSRN+iMKSYUaKIma6
         KNTFl9mSfhEb5E1hy1ublquLlEiXd8jR9r9vKhbz0NiiiqT9igpR8cttzfImg1yw1pfH
         wWXTHkDMhf8Vo/ZWcWE5X6K7SnOCyL/R8ZSiiry7pPGiPrKdmrPaOkNNq9/jHKXRiaCB
         2tK5WTpW4uyffAe5S/nSQ9W4njHwxuAJGEPcL60TjQswxVnz4Py4XRelMZIyR19h3uta
         FSN9hyvGzHcZJgds07VYcDGOxIUtXzQy3cONn5FpqEr0o4TrdwwBbZ5cp06hyfW50Fut
         Snjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783519222; x=1784124022;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gyOhrDiD3HZi1C97C5b5wI4tA2tqQIhwOgRgckqnDRQ=;
        b=SgzACnU7htIeSzD9NVpNTzQZtXQ/hydJqPEAOzU8GYbq2PthZleOx074e4egqUxmXp
         eo4O/3w1B4NdsVIL3Mv3tmKSTFOsibjqM1nr3H7w2tp2WSeW3yGuxMCDj4NiXxX2pHv5
         TD/rHhVetFcrEfx4DlV9g264nN/l/YiumPF/WxQKHKt+fBtUghYhZK2YEO4f1z/n2ktb
         WXtn4ix8KnycqvvRne+kWazgbbN2PpdiLZOgII4ePFB7x6fgBkkMMBS6Ovw0VNz8FtMp
         c+8chQTTENovmaIAONInYa/6exCsB3D3fX8rCvAwuWLtrgIvQboe8wvbl1gjvdV283Nd
         39uQ==
X-Forwarded-Encrypted: i=1; AHgh+RoDGFOsWCiVeqLYnHVxmbJUEF0V+f6JyvVCq1ltc4fJ63DRmzdglBrvuyu0X7KOfgNfYXqVTcixXJJHn1r6EA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxkmL6l0m+E//FVo7X31W/H4fP2jRCyx8EN+bMAizF8IVtpJCt
	5QWNgBFchq26UNasQycXZk+EeLBZl/rp5M/4Ug2mQWNErGcIUZWKpcyHvsG9kU7ekEk=
X-Gm-Gg: AfdE7cmoF8AXq5rclxLQu4Z2cbOfgUWA0pGqA1B5sh819I6jcB5H6l/2kObeTX0gAGk
	6u54RifbvpgAwIQKs6sJZ/7ON3MmdxodkexCNmYVQ4CCPAeYbEUTAMUvNs+UqXu8ycnBZrBRuQJ
	lp2MnTMHOZfzhTeQ0MoSKfLahftrkUIQlVI0wIOqwWdJsMyg0auZEzYmMgZWv22KON8q1q2qCmY
	hGfbTsIIHH26UMxZi3FFOCee7J4usD2wL0QiQ3A+HbdK6FNuABnAk6OsK6Lf53jI0dRx7YysHrL
	whV02vVU3eWANkjXTdZX/ku/s3SnAXK+RDY7RN8FJuk37+6jWrqQ0Lpk8l4i2X02s2pxWvdpZFU
	o4s/f+LA7gtaH02Oc00A/Shq50BTUffBYnjQKWVR19E2H/WvDNIJ9hgiJODWgc3KuY+BbulZ23/
	pQJ9f+Ebv04pZzclY=
X-Received: by 2002:a05:600c:3acf:b0:492:68bc:3237 with SMTP id 5b1f17b1804b1-493e7a2b209mr20847575e9.32.1783519218219;
        Wed, 08 Jul 2026 07:00:18 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0faee30sm120828745e9.10.2026.07.08.07.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 07:00:17 -0700 (PDT)
Date: Wed, 8 Jul 2026 16:00:15 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 3/4] printk: nbcon: move printk_delay to console
 emiting code
Message-ID: <ak5X718OcOi8OeT4@pathway.suse.cz>
References: <20260630-deprecate_boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260630-deprecate_boot_delay-v2-3-f9883d36aa4b@thegoodpenguin.co.uk>
 <87zf08w7qo.fsf@jogness.linutronix.de>
 <ak0b2S9jjYy49a8V@pathway.suse.cz>
 <87echdvkd5.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87echdvkd5.fsf@jogness.linutronix.de>

On Wed 2026-07-08 12:42:22, John Ogness wrote:
> On 2026-07-07, Petr Mladek <pmladek@suse.com> wrote:
> >> This is too deep (also pointed out by Sashiko) because it multiplies the
> >> delay times the number of consoles. For the legacy printing, it would be
> >> more appropriate to put the delay inside console_flush_all() and
> >> legacy_kthread_func().
> >
> > True. The question is if the proper solution is worth the complexity.
> > We would need to pass the information down two level of the API.
> > It would require adding a new (output) parameter to console_flush_one_record(),
> > nbcon_legacy_emit_next_record(), and console_emit_next_record().
> >
> > It is not that complicated but these functions are already hairy
> > enough so we should be careful.
> 
> Fair enough. But then it should be consistent and
> console_emit_next_record() should perform the delay before allowing the
> handover. Something like this:

Great catch!

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 2fe9a963c823a..62fd6a5ebef66 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3161,6 +3161,8 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
>  		 */
>  
>  		con->write(con, outbuf, pmsg.outbuf_len);
> +		printk_delay(false);
> +
>  		con->seq = pmsg.seq + 1;
>  	} else {
>  		/*
> @@ -3182,6 +3184,7 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
>  		printk_legacy_allow_spinlock_enter();
>  		con->write(con, outbuf, pmsg.outbuf_len);
>  		printk_legacy_allow_spinlock_exit();
> +		printk_delay(true);

It is pity that this is inside printk_safe context with IRQs
disabled. A solution might be to call it before the write.

But maybe, this is good enough. This code path is called from
vprintk_emit() and it might be in an atomic context anyway.
Also it increases the chance of successful handover which
might help as well.

Anyway, it would be nice to mention these pitfalls into commit message.

>  
>  		start_critical_timings();
>  
> 
> John
