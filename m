Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB533C3452
	for <linux-rt-devel@lists.linux.dev>; Mon,  8 Jun 2026 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932378; cv=none; b=RZAlx2hyr/aE0TY8dKW8ZQRvv48Fkz4eoDG7X72CiYaG7VAFQ7lxM9UEzwD+3a2O/7uLoHTule1bXy+CNRo4rqYxlITffX2lx1E1RE4oEkfvC6Qce+inJ46fvaNlFz2aMtA0835U4/G8CjR3wOualduAK93hlk/BVHNIuBBl8lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932378; c=relaxed/simple;
	bh=yMX+W8TexPELxSvmpULoxgUGLRWGyyYeAcw46HTv+u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+WvNeGoGerxMhml566dmIRu9Qh0oHxThwYaLEnpiRpCGtOLnK+ykd1Qp+P6EONq69k6NIzq/Bni6iGFarg2VvmMeM9hKic9pZD6OczLj64+AXQffvqfD36k2zTZYByQqSFeFfkH5U+XVxKYTQxcjETeC2sUayh75MSuoJ2L0Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FwgQIVsp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FwgQIVsp"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b9318997so33107315e9.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 08 Jun 2026 08:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780932375; x=1781537175; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zEvrj3FcHgr8xXb2mLKuhtzTWtWLNi+whddxtH2ZY2w=;
        b=FwgQIVsp9xRXZX5ktzRuiIyLHAtWjAavK+aLxCXu05O7mFRKaPiDXmOhmD96ja9mCo
         XYqo71B8eW760bNWMBBkS/e8O1Fe0WFci0iq6RCwuJZpIZ1+YJiZgGllKhMLx566D5e5
         mfz1b05p8Mbwbetkd4+G+Uj68+kJNsZJpgRMFa4y7d7qV0ZM6k8i+6NQqOQaDr72VDJP
         b/+Jz6U2EKIjVvzFtIG3vPqkVTvQ9LDAGtyyVm//qFpBxSY1m5fBeJbw25wcupGnkP5k
         uPiSqGySWnJf11Yw84ka3rI2wshEXfQU/FXxG0lXzetIJBYx7bR2N7HOpSL95ycGDto/
         heaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780932375; x=1781537175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEvrj3FcHgr8xXb2mLKuhtzTWtWLNi+whddxtH2ZY2w=;
        b=pkBVOXo7FDcNUDN520S0xUqetG2HQevYAciTXpMdgD1EnYXlwvPFKJm686uQ+7yFze
         BtqjdMWRYwOeb1n9o53VsJfgbTsHpAni1a+wsrZNiS+GNwZxcwSdVDm46/RWttQEYH6v
         3fLvGT1uR0ct/eUhhfcYcNIcDMCRGL9uoxBBYyTPV3Dwnl70DRPynO4Q9njfrN2x66kj
         QL3q/1FXQkikAGp/PgW7Mpudqc2QUvoWbyhyPM5SK1CXPllmOSfMmQdH4FbCarv8uAV1
         wi/EC+nMNsMLCdQIFuGhwVIwMDU0s/qwSaz5XzzqaQUlI0/s79X5rt6UgIeu8QOJXZyC
         Wwpg==
X-Forwarded-Encrypted: i=1; AFNElJ9OTggXIHg7X9wuB2bD0GTOFXbWakapGfS2T+7k5EaQmZ96V2g7008RNzx3hNCR20fAxvITqQkXiDq45/1ZGg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxytFUy1Mm6hn2axy44KNvHkcf+5gBqnqfFhg+ofQMRVgq5tkSl
	huq6FBBDBowc99QYRR4vIe9kFOO60efZkyq1/LpjKH5hRyfvvr+VtnQYlyl9Eac+1qU=
X-Gm-Gg: Acq92OG8egicxHUbDP2Ym7PHltJYjpdhaMobWaVM70yPiOcsTCp46v6nZ3MaaA0DUfD
	WrUF1ktCHtHLTvc1hZYw3Bw8k6memcNkjj1GDCJdr1AX6qxWKl9t/EvJfKJpHoAppAPsBbY299y
	ZhyuuG0TDx23NdwW/z1TZQHsiUQz8JCgYCLZhi47LUSfXdfl9Rg5wNn1w7qmZM6ifFVUbfOQDv0
	ZJCB2Dgh0WfTC4mpsQfjvfYirF0e1/2lbsQMNS9uvGNvUSJ3UWF0WSlp+tOMke8VUG3na09H6er
	MoykFnazSzmyIV+gRrivheFVmohJFxjAoT2RGHbGzhSXhrc2pmk05f/Lcsc6G6E8TQoi8UtwJPi
	krZlhM6ehNRgXC+6FuthG/PZ9fs0Oc3it1RkASHAhEklL9vR4T5w9si7j4Zozdjob3kVwLqEAEd
	5oyBX910cudk208cc/HOOjMHfp3eqx+VmnKsaoU3C8Zdw43Ig=
X-Received: by 2002:a05:600d:849c:10b0:490:b58a:e6ff with SMTP id 5b1f17b1804b1-490c26e1aeemr178859365e9.22.1780932375459;
        Mon, 08 Jun 2026 08:26:15 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f360bd6sm57162809f8f.36.2026.06.08.08.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:26:15 -0700 (PDT)
Date: Mon, 8 Jun 2026 17:26:13 +0200
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
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH RFC 4/4] Documentation/kernel-parameters: add/update
 printk_delay/boot_delay
Message-ID: <aibfFQpK0Se-SiaT@pathway.suse.cz>
References: <20260601-deprecate_boot_delay-v1-0-c34c187142a6@thegoodpenguin.co.uk>
 <20260601-deprecate_boot_delay-v1-4-c34c187142a6@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601-deprecate_boot_delay-v1-4-c34c187142a6@thegoodpenguin.co.uk>

On Mon 2026-06-01 00:17:40, Andrew Murray wrote:
> boot_delay has been deprecated in favour of an extended printk_delay,
> let's update kernel-parameters to reflect the addition of printk_delay
> and the deprecation of boot_delay.
> 
> Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>

LGTM:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
