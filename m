Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC16420461
	for <linux-rt-devel@lists.linux.dev>; Thu, 16 Jul 2026 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206915; cv=none; b=Qob0y3ozIHixpN6Q80kxCqnDawr3Xez/LQzo/LdJnIDE2riTE9lWJnZ2rFeb8aUcZeGQt+y3p2k9bc00Le7lSkIobRipv45blLd2XDZ/YsCj8kzFJNWgghO+lSHYvfGBi1ec59Mhmurgl54814GGyQBfiVxFI3UBEeYA+8hsoOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206915; c=relaxed/simple;
	bh=hEAm3YmviD8vfyxeIlYhDFGhYvXOT9Fr2VwVTcL7UCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPCcJiAfn1MF4HlBVyGsCWPSvfR90ll5twwuJ5P56t7gdV7Z8drB/hCvPG1jlV6jFArLiplWAlZWPyIfuX8rdoVUlq72tqj4DA0fzG/LdLaZFGKh1L8dWADwZ5VKeqx4KSTx6oGUbCrek3lU+MQQeiNgkP7qMOsY7ARH9ywRl0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MJKW/UCb; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MJKW/UCb"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4720d22c94aso3588594f8f.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 16 Jul 2026 06:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784206910; x=1784811710; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GMRGU9D7jUOPRMQdlhC2i0jxS0Sdmf0wGcAUKJ73Z08=;
        b=MJKW/UCbXyq5180YS2WMAWcPLS8mNKdC+UD1FywmzpaIHx7fNAZAH62ZDHrOqBZSvN
         K716tyumoOEFVViEQUCKtOY+fXZOMpn23o6fDo3LlkdvkEEZ1EeOInSvbr0HXyNn9PRc
         NBh0HvDY/Y3YsB1k8QFe3HIhAs1CY8Nh3NpIVSMs/pTlS0RJ0TNjjFqt11bUR7omp4Bo
         vK4YYb14T+9TJSTQr/t8HkfcF74IkuKHh+Wdn7DyUdb2cIgRuEsioh5A5I8sUcKqbUeb
         yEHOYrFcxGsiGY5AK/Ji8DPst7ldJNz9nmqlPbHPUP6ME3+snfNVj3B4vPQIRsb0mfU5
         QgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784206910; x=1784811710;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GMRGU9D7jUOPRMQdlhC2i0jxS0Sdmf0wGcAUKJ73Z08=;
        b=j1/QbJ9PgKtp9HEzpKgbOAj1SrdBpQwSR8E5HGm0FzEeMDKi3QdHuRzaBeARaSeZDB
         B2LlQPFGp60pcq/7Zu2Dg5zQuvmUApx4C7YIPFSVhOtTXmIaRrqB6VwoT90sECbawk4k
         MMtfLI5ijvOC9OxpG74YK4G+vThJUqQ/Gp8pnfQ9YosPIJVkGVUrMZPmG5iRg6+p/1mE
         lModUT/6DggvzgOTXaovJ1fMf8QgvUaR/xDajbEH6JWVwmAJd+LFGXNDDEGUJnv+Duc0
         sFN1ZUgOyA1RjYZvAtCSzhV0ytQog4HrjsgskzLzvqVRGvbRzsmsXG/B+whkamYL5Tpr
         s9Mw==
X-Forwarded-Encrypted: i=1; AHgh+RoVEcmgeNJbOfM7R5fCUW01KtWsMZ835YTMjY4uL3HsAM6LctvwibLCy5DIV4IGVu0U6HbOPhFk+Z+Vzd/H9A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxL2lQaz9c+H8P4dhpQ6i1JjU7y5MxQ40Gl97WC+mZ5hojE8+XA
	ibe42fT77kmh3BBGDK3k6HKm5hXca7qCG/M3oUpOPL5gj4QYmBqQSXK7HaT6frCR/vI=
X-Gm-Gg: AfdE7cnGo4mO4OEwe2MYAUHCWc/lWaSQpm/nMSJGWL1A8Vmsj9e5U4SV4/+hwYBPlW9
	u9Nr+6ysD9LMJQVtmGWya6cP9GuQK7HEgn44CsM6NZEOeGIpCN3UmWP8B5Vmd0NNKo1vblDV7I3
	xTaSyygp/va8ybaKZSkMBstUx7DqU/wDdpQmHPWupullqCWZgQEBsWqfjhfp7UxKnav8spE4i9H
	FtyZHjBaq+KyADalWSs5M5N643UD31c8o/DljaNR3ZMIBOKFjL+91CSFV+WarXDVQpfgenYWVKl
	3ZdPnGKWOpONsDRGolDv0q6BQU/5PYUYEUTJDFALmUjq5A4PofQE3cqfF4lZ20Pjiq0eBs3MT7c
	WY2Soi1WcwVjf8Fmf+J0uYFk7mBdB1Yo2p3jQWtviIJcNFWu5d8kpvwtqeJtQqh8in9+biiyDjR
	laT0dp
X-Received: by 2002:a05:6000:24c6:b0:47e:1d9a:1123 with SMTP id ffacd0b85a97d-47f2dcb604fmr25617566f8f.3.1784206909702;
        Thu, 16 Jul 2026 06:01:49 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e0d9sm23377950f8f.2.2026.07.16.06.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 06:01:49 -0700 (PDT)
Date: Thu, 16 Jul 2026 15:01:46 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v3 1/6] printk: sysctl: use unsigned int for printk_delay
Message-ID: <aljWOsuEfks9mYql@pathway.suse.cz>
References: <20260712-printkcleanup-v3-0-574547b8f71b@thegoodpenguin.co.uk>
 <20260712-printkcleanup-v3-1-574547b8f71b@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712-printkcleanup-v3-1-574547b8f71b@thegoodpenguin.co.uk>

On Sun 2026-07-12 11:20:32, Andrew Murray wrote:
> As the printk_delay sysctl represents a duration in milliseconds,
> let's set its type to be unsigned int.
> 
> Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>

Makes sense:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
