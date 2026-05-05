Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252E3426EC5
	for <linux-rt-devel@lists.linux.dev>; Tue,  5 May 2026 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991205; cv=none; b=FLO8QTEi9+BWonyKeyCm9snduJTbKSrC9JK0z2Xcx2UD7HcacXxdUVrIEZoxqtr0SEeZ+dfHjvkHKXwqM+TZ4+jUbN+6m7D4ofVFbdbgkuQ1c4UJhlnBJtMOfLCAiU1Xhysr8M98yQRHKs8XcnyBZ+y2KiklOcIsoigl1DJU4DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991205; c=relaxed/simple;
	bh=R+Bl4Tihft3hXjytWck/czW9kH+Ro3JoXapjuLVVGCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6782ra6f1+KKNAmGePRe6+KGND7znQF+XCJVdEwsDzJ6H+MF+9x1KhmcSCNK2KZQQTqF04sGsovFu9o07GoSLxNZDxT+ppgY/pNBpZVRvrJ24ItJi54g/Fcl0U/nAacBuvdncKhw310/ti3Q7RGThdOti02cdxd5fE3b6panqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DVCsbqXQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DVCsbqXQ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488d2079582so56739305e9.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 05 May 2026 07:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777991202; x=1778596002; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iYyeBIbryO8JN51e301x9bqZZvN4oLOHjzKYFZ6iv5U=;
        b=DVCsbqXQFeMIEXghYaTF5ldRJGBKPVmhYzL2O0fDYy9YTP6i40XXuMSP1c98/YvdqC
         lmxsAR+g0HvpN6FRVxBivks/oUhCDWwxYQ155zxDoo4TUFzqgEHcZgTY+i1rJjPBqPMB
         2pmlX3PeSC8ERFqGfYAguMknx1fYuTHhTsWlV19rUgg04T2u0lo8LJCcZizT6+wdLDR1
         7YRAj3x0Et5ImFi8VW9RzUibcAVxMSNWYgLJ17BeGJDrH/xRIVHQHxP/mPcwn/XqV5JS
         9BqE6z+0/kz8dr/8Jg3prVGkIoCFBeByF8AzptfjdWz0GAxCVjVO0N8vfrfDcb2ND7zR
         1HHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777991202; x=1778596002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYyeBIbryO8JN51e301x9bqZZvN4oLOHjzKYFZ6iv5U=;
        b=Reju/jJmMEiGMwnhZwu+flTQJydcn6arVhQljzF77KWYNip2pQ9HTHotD1IAg56nJh
         fSgFKnGDyTgMHKS8eca7xglOzAbTasIxdXGzYVoCx7nHNMmGh7Tg2mdCeRRAUOMNh0hG
         PaJvLeQfBndv+B8pJyeSuClOYUuqCc5rzkBV4RRtJ+gyGmKgbGczZmVc+2LZUZXaM4Gh
         k5Ji94oE7n4tmkCpYol3cyd4PTt24Vd+Zq1TLXDUoDyYEUwYqaE9a0AZ+PiQPfZTRS7s
         t6TJeZ3ydZhS6YUDGNx3e88nR027GRXW405vxovM19t82xysIiOkUoGR4OyOrxrjJqmT
         jgUg==
X-Forwarded-Encrypted: i=1; AFNElJ+Rcwi1DKi5e10/pc8Iwkhxo35iAAh5eTIpQMN4d3KfvI/eHNEdAiJTZsz8q+xZX9omnSrljXRkfhMH4Kraqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqUxiQn9Ec2sy3ygm4PIaaXuWgwG9dqEtLVE+RhpO63tnDAo9Y
	rapOCTAs3AAIHW6kkHH9cUHPAxzZzbuCQz4GPqVmr8LU+wNyJ32/+5Lf7wIlNpETQ1I=
X-Gm-Gg: AeBDietOefQKq7gI2Uq1GftGJD3Asrgk0JEuOeY6K8pHyGSEciZelDLfnBCAT0a9N3O
	JNF8LXJr029aW4mQCKtU9V2N5hwYqcSVwoXtxlsskoRl/C9CHyeT8bNBxRHXeAqONZgaPFaa6iL
	LAyUOg6RppNtYuTKYulyLFSLmkr6rTqgNUx30Ef/SxBxU/Y5A4qj/gwfZFmbNLVhABTfHF1w0To
	KtB9u8gVMLNpDv3OCKqvESKbbM70+7A2S9HJj39KnuYdtskUChD1b2S7IgfDTuAmROAFEzIALwr
	Qr9TCG8Ewtj79FuRJ0BkXN7fiIgShpY1kW3cn4T3DlAF4kithoUQrv1ocmD7eX8XnhOroikJ/20
	DkAmhiEzLm9Ja69pupnHQYgitis5RgdP8lOCP4A3KCqsQh4Or8vWQRQdKnH9jBWq7SoS39WAFH3
	C2EtSMkOWJRAftfIoSJJt2TrEQgoINXUmnWH93
X-Received: by 2002:a05:600c:4ed2:b0:488:a639:b772 with SMTP id 5b1f17b1804b1-48a98639ca9mr248173345e9.7.1777991202385;
        Tue, 05 May 2026 07:26:42 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d17ff35eesm19631165e9.14.2026.05.05.07.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 07:26:41 -0700 (PDT)
Date: Tue, 5 May 2026 16:26:39 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Clark Williams <clrkwllms@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC] printk: remove BOOT_PRINTK_DELAY
Message-ID: <afn-H1EQJxnDs0BZ@pathway.suse.cz>
References: <20260505-printk_delay-v1-1-5dba51d7f17c@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505-printk_delay-v1-1-5dba51d7f17c@thegoodpenguin.co.uk>

On Tue 2026-05-05 14:45:00, Andrew Murray wrote:
> The CONFIG_BOOT_PRINTK_DELAY option enables support for the boot_delay
> kernel parameter, this allows for a configurable delay to be added before
> each and every printk is emitted. This is DEBUG_KERNEL option that is
> helpful for debugging as kernel output can be slowed down during boot
> allowing messages to be seen before scrolling off the screen, or to
> correlate timing between some physical event and console output.
> 
> However, since the introduction of nbcon and the legacy printer thread for
> PREEMPT_RT kernels, printk records are now emited to the console
> asynchronously to the caller of printk and its boot_delay. The delay added
> by boot_delay continues to slow down the calling process, but may not have
> any impact to the rate in which records are emited to the console. For
> example, if delay_use is set to 100ms, and the printer thread has a
> backlog of more than 100ms, perhaps due to a slow serial console, then the
> records will appear to be printed without any delay between them.
> 
> It would be unhelpful to add a delay to the printer thread, and it would
> not be possible to disallow selection of CONFIG_BOOT_PRINTK_DELAY at build
> time as it's not possible to detect which consoles are nbcon enabled at
> build time. Therefore, let's remove this feature.

Heh, Randy proposed to remove "boot_delay" few days ago.
This RFC goes even further and remove both "boot_delay" and
"printk_delay".

Honestly, I do not feel comfortable by this. The delay seems to
be handy when there is only graphical console. I would suggest
to do:

   1. Obsolete "boot_delay" with "printk_delay" as
      proposed in Randy's thread, see
      https://lore.kernel.org/all/afn2sYKKsqG4QBVX@pathway.suse.cz/

   2. Move printk_delay() from vprintk_emit() to
      console_emit_next_record() and nbcon_emit_next_record().

      For nbcon console, even better would be to use a sleeping
      wait in nbcon_kthread_func(). But it would need some
      changes to call it only when a record was really emitted.
      Also we would need to use the busy wait in
      __nbcon_atomic_flush_pending_con().

IMHO, the only drawback might be that the delay might be multiplied
when more consoles are registered. But I would ignore it. People
would use this option only when the graphical console is the only
one. It does not make sense for serial or network consoles.

Best Regards,
Petr
