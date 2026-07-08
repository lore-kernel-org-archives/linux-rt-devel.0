Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8594C901A
	for <linux-rt-devel@lists.linux.dev>; Wed,  8 Jul 2026 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783522885; cv=none; b=cXXP2zTsTfBxT3jcOgF/JWAtpzMkjBDQFHxIVbAyYpWSqoAeHgH6K46qlB9dYtwaiRMvAU5d4J9nQtYV1n0oA4t1lRBOBU3ieUcunzLGszD6lCKr3rMqhuppVYORxT+YsqUe+SLsCY/7qcFYc1/GutbmmcTXIH9gKl/ag1wuEkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783522885; c=relaxed/simple;
	bh=PyWD7vv+PrPGGDMvNSumMzBl2dGSOH4pmZnHK+3zSzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDRv7ZbIdUYjz+c3AtndPj4WXs1+xDDmtNTIFSBgtj6zQukakhWm/rs3d+vrcMvnPgYOPHxxA5PJXq/KrxrZiKi3ww6EVLB/13ZaRl19Lod+bHi806CipgCRN0KtUCXefTxI+t9+nmFnQsClqC7yvKaAHdj6KOaUkoFHEvhZCdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=flbb/xiO; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="flbb/xiO"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4629051c9d1so469438f8f.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 08 Jul 2026 08:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783522882; x=1784127682; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6o/0oz9zzNfbXHaSSbGqw9HJrGj0kr4qZrqpo2nmLDc=;
        b=flbb/xiOTfajUeFexEDgOhQWC8BoG4hIxLE6BjwWzwx0jY5+U+ydZT/MI2+cHGfLL5
         FJ25qE0vEpGRXzRZBmJfG6cdWZwKcVPfWlvfihu9c9uY0Dkp38PnJ4Ql6qrhMaRU5msZ
         9aFuuvGeGWP5YhXzEKa8a/8nrpooCcb3XMUYaFmuiqizAGw0bfgzgJ7x6ZSLu340Q9n6
         NTe32PRW1MbnMO7ofa1oMYlhdq0gBF0gtLM8DgX/cYkK/wpVghKpMkVyqqDryWjchlyy
         xg6wV3cRKNjQ8SGeQPV6vNL3NU/QMxTBVSc6xACHWcBjEvpXLgmZwDdWW0O1WIMJyipm
         gaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783522882; x=1784127682;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6o/0oz9zzNfbXHaSSbGqw9HJrGj0kr4qZrqpo2nmLDc=;
        b=OxVK+cTMRKxmpRFThdb2V6GznHTRZ/eODov1qv02jwi3m59sz7/pXVPnYoTBqrDv+u
         jTWDXPZX+3I6kChoygLnCyu8XcDrmsTdXvQK3EGLRe5uKHlNV4Nza2N2aLCQ534Cd/WT
         uBx5tp1LIt2mWdR5kFBpXMZOlkkNgB0uW2Tuw6B4uLE03siXYYSPGzIy4vAjehYQkDAX
         +/pS6ay8ImUx+yncF6B3iSf3SYpC+b4Eb/3ObVXFoSwPp66dLPX5W+PWPL0BYY52En4q
         3ZjuAZpwfwyPJx2QdH7WQYS0FB1YrCcpNUF+UY7o//akQiD4eYdvkFvjrOR6nDK3N/I3
         BjPg==
X-Forwarded-Encrypted: i=1; AHgh+RoTvds0C02ORez9A76nKUdjN7k+40ogpR5aAwCGGPL2YubxYNOFtesAA9uon+bx0ylTKBYHxR1Qt/qA4eeX2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMaVCET6p6t/49du8sVU5C3L8rtAun8JhjJ8flFvncFBuKyPDe
	mm7xYoukJjlH3VvGbc5/E0s3/mypk+hnwtrE3Xx2y1DsljuBOGCA5BOh6lUDur5tMOM=
X-Gm-Gg: AfdE7cmAGnD+f9qBByuUV4+/ZGU/xx+JVYo5v5JxXgX2wde9hFV2HbYXLO7t8HgETjv
	CRHZL4P79de+7nt19cerQRcYGXUJnAEBIcposUTmZUA2Du1OFYLWowOIJoIQNVsz3+NT6eK0qUL
	QSi/vcxaqoI2/7Ck53xyfV0zkDh08I9Ihg2sINvNpHF0P3XY5GYZTbjXX4cxOqb0fPA59T5lpmS
	c6BoVnUvhqTJaoeh4cwl6R5I2Z49thVa27luo/Be9pjBXISWPyuJ0hO7qUWqVAZwycqtCDJ8+pP
	CDXjABObnHWnjZofRGkON2bYt7xucVUEgjzxZUeMA0rLgw++d7i0vGg0C9bTiKMSEpq8eq1Ad3+
	b+RLVinrf2Zf1+iPHZi0pmYlDJOfr4Ku2nA7MPa9utbUVBnzFp5VyP3kziQdlVrh4Ops1/ZxC+p
	JvA/F6vnQ6T8qwly0=
X-Received: by 2002:a05:6000:455c:b0:47d:f43d:8947 with SMTP id ffacd0b85a97d-47df43d8a02mr1010322f8f.47.1783522881817;
        Wed, 08 Jul 2026 08:01:21 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm39225385f8f.31.2026.07.08.08.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:01:21 -0700 (PDT)
Date: Wed, 8 Jul 2026 17:01:19 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
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
Subject: Re: [PATCH v2 2/4] printk: deprecate boot_delay in favour of
 printk_delay
Message-ID: <ak5mPxUdp2pzCMt5@pathway.suse.cz>
References: <20260630-deprecate_boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260630-deprecate_boot_delay-v2-2-f9883d36aa4b@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630-deprecate_boot_delay-v2-2-f9883d36aa4b@thegoodpenguin.co.uk>

On Tue 2026-06-30 17:35:58, Andrew Murray wrote:
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
> 
> Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Note that Sashiko AI warns about possible problems with negative
printk_delay values, see
https://sashiko.dev/#/patchset/20260630-deprecate_boot_delay-v2-0-f9883d36aa4b%40thegoodpenguin.co.uk

But they should be handled in both the early parameter
and sysctl interface by the "10 * 1000" and "&ten_thousand"
limits.

The only potential problem might be a warning about possible
"sign" mismatch from the compiler. But I do not see any
even with make W=2.

Best Regards,
Petr
