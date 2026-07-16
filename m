Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100B23CA4AB
	for <linux-rt-devel@lists.linux.dev>; Thu, 16 Jul 2026 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208976; cv=none; b=ht8jT2z0G/X9z6cu4cQ5vEmb6SxjEDpPqrjBY29W2SQbutr55z6uQLtyIfvAhuiwxcNIEbKr8P25bWj/z6rZGXSezQigfPKEC6IqYR2gcmH5Hlu8pHWTJKy9jN1zG77zbausED7zvVbWCDI+20z8EdQEccsYbbWAtCsYxLa8Ja4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208976; c=relaxed/simple;
	bh=Oecs3cF7VsLepHL3npOZJPC4VeDjnKqWP0cNPB4v85I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sy95usov/BDSaYZ387oBaKDwZAHKfRSTqQUBRjF1ipGAOmIZP3N8XjSK9dplfdeykFumcwHvI874RJxWVtJDRJBdcidiL4YQnMNJb0xN55B+UiVD5UMpZqM5EITmHeSwjFGHcDNuKTAvy1FZpqRbdTLq499GsCWHEcYXen08uUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BL+kYXD2; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BL+kYXD2"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so54550905e9.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 16 Jul 2026 06:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784208972; x=1784813772; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZxMW+cZvUWvRljOA6VXL+6atXYnie85udU5ilmsN1H0=;
        b=BL+kYXD2ehZoyLW867XsmeWG4DPCk+VrKWTQtD+uSkI60lu+Ybo9/UETF+FAZPfKJm
         WaOXb7ehTq10SxwgF1gKLWiL5UZdg9f1Cq00yzNNZje08BAnHD+SAbYG/epUhD/6uCsS
         e6WYqb2YxbpXda3RvxAovZNkkSv/WYOhABaurQKejBlatFO7VbGjdw3QxbcpKEBd2n1X
         d4pDbbzRms2wVJoa8OSMGFTjLQQO1eps6D9Fi+82/WfJrzDHJSfImWiUJrez6BlSZ9eS
         SzY3WZNMH66wyW/GwGEiHYXABG7lVWCgjY2rCQznGXLH+jHssAxsnd13hAZozLmT3Z4Z
         4JvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784208972; x=1784813772;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZxMW+cZvUWvRljOA6VXL+6atXYnie85udU5ilmsN1H0=;
        b=WUJ2ES73rCD7xqP90jCbl1xE174wYOD4Eq5TqOtrjd6BbJVAk9UCDhTie7kXUdHTV/
         JuQP2zKvsTDXEqCZ34y6jipKOer5w1tVJkw3bie97TB4JqN/LCEmgweQtjql4iaLS1f1
         rkTqnGNfiAO3+kssANXusNTf0Kmt94BlZvOLLVmSCTiFHZX09ydGgSzj9zX8vHRoomjS
         6SLGO/xwY8vJs0EEMtTw+X6SsPvwhKzWbV/kfLF3CR9+tjSzmyN7yig9+mPBGdljxupr
         z4sLNfcy3ELVvrnR1SftdlJd1Vg5/tp4W4m4uYaDDwtaOqZerxthVfGq+Tm4Gl5B8uDj
         YVxg==
X-Forwarded-Encrypted: i=1; AHgh+Rq+UhrjalEB8TdbANZlVWucBdoVhEdmrZ15b38eedKArzmEOWsNiiibuvMDV0aTQdH9KZwvSWvbsgEYz5EXKg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6jYI+MnhaOvJOAsT/D0TzJ3Sggit4xxWT11VDJja2U0brWFQ1
	9CSKI1HpjP7Fe4ImecLpwZ880C64xg3K82Wm5CXxw+42jh6g43ZNi3cuae+Gip1SA/8=
X-Gm-Gg: AfdE7ckBvIO2na4vsgC8ROFor9P6ogxWLd9L5iQWlJfDGUaTwB3OXPRS/cgAbjU9pUc
	qLds66GbI/qGBjkcLL06zXcE5HmpPv+sVeXCBxIjS8SvHjaSR1nwK2LA//sBrJqL/xo6Vxz1uc8
	jKd4sUSEMq9dsPWVf+LAUTpavwpvlKFU6cNfKmx5LYL5R8Gjcr6UPnizTZE39i4mgDLLX1CLdhA
	7Cy8sirYgsmW6cUO6yZURFs7PH/EJ8ldOXMm/h1QJsuoCBFHwu7FcvN1RrfzSHGkVVhXBVfwkef
	jladNdVbVJN6I3vJwfcoF3wMyG4JxqVs2qITxU0iBBZvNpXYsed0R85cbIUi39OS+zoFEzOnOqP
	0LouHRj/3oDvwQ/dhT4mvhv2LlyCovtCfTBT9QGjhN4poPgU4WS6yZZUojXqKKLbwNVDMaSvLKZ
	ncy9d7
X-Received: by 2002:a05:600d:644d:20b0:493:c601:3e23 with SMTP id 5b1f17b1804b1-49538992cfbmr95343205e9.5.1784208972253;
        Thu, 16 Jul 2026 06:36:12 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c1f84sm24902683f8f.29.2026.07.16.06.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 06:36:12 -0700 (PDT)
Date: Thu, 16 Jul 2026 15:36:09 +0200
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
Subject: Re: [PATCH v3 4/6] printk: deprecate boot_delay in favour of
 printk_delay
Message-ID: <aljeSRmY7K38ySmL@pathway.suse.cz>
References: <20260712-printkcleanup-v3-0-574547b8f71b@thegoodpenguin.co.uk>
 <20260712-printkcleanup-v3-4-574547b8f71b@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712-printkcleanup-v3-4-574547b8f71b@thegoodpenguin.co.uk>

On Sun 2026-07-12 11:20:35, Andrew Murray wrote:
> The boot_delay (BOOT_PRINTK_DELAY) kernel parameter and printk_delay sysctl
> are two distinct mechanisms for providing similar functionality which add a
> delay prior to each printed printk message.
> 
> boot_delay provides a kernel parameter for delaying printk output from
> kernel start through to boot (SYSTEM_RUNNING), whereas printk_delay is
> configurable only via sysctl and thus is only used post boot.
> 
> Let's deprecate the boot_delay feature in favour of printk_delay. In order
> to preserve functionality, we'll also extend printk_delay such that it can
> additionally configured via an early kernel parameter.
> 
> Behavior change:
> 
> The delay enabled by both "boot_delay" and "printk_delay" continues
> working even in SYSTEM_RUNNING state. It must be explicitly stopped
> by setting printk_delay=0 via sysctl.
> 
> The delay is skipped when the message is suppressed in all system
> states. It used to skipped only for the boot_delay.

s/used to skipped/used to be skipped/

> Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>

The code changes look good to me. With the above typo fix:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
