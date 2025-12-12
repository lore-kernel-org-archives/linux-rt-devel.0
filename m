Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A123C38
	for <linux-rt-devel@lists.linux.dev>; Fri, 12 Dec 2025 07:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765522954; cv=none; b=ZqcoM+/rN/gkAlPqrYuCSx1MZrFhO2XiZ9sbeyySOu5Y7UuVuBM2fFy6p8xLfNAfvaT0JKctXuVL0UZ0BdR4MmLhkypCOKOFn3WhhGytvk6I1EI9L1xxSNKNOfnm+KyTprcC9yvghsvDcbFuoTvaTlu0aACGeicaDz8f7+FEtuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765522954; c=relaxed/simple;
	bh=KNEjlvnFjnMK2hlwcSghpX4aglZgdkRodgMgPJTdQyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfWWXhf0yCeT23uyXsxOWqFhie5jVjc9tidXQE8oa1q9FvWmzVOVlhSfDdPllUAQYlKzAxuwjRCMIGRKREUKKZZvOaG6LWsVbeFpcnHgMM7A7TX4m2JRBT+MOA2kmgeTV+31ibufxPXuCBpj9ijrciWHJ/hQCPAvWRUgMkir3G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BesI6mC+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BesI6mC+"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47a8195e515so7369535e9.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 11 Dec 2025 23:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765522950; x=1766127750; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8J31nkKLMTJ/Qo0J4+PLRi2H/hsgHiES0A2U3TOlxM8=;
        b=BesI6mC+3GYbrW73eoU+EZFqEKSHiJFi+Vk3D7dPXyjUu6HIXKZ6HGN7kNmWdvdLHW
         QnsmhUKmJ+zLcrqN0MEYJvPacyZByGshxKEqqqjbaKKIQthKUOZ9MOolE20HCJ5sv9il
         OK/yamdtM0U2C28WjdG7W65NjNsHD9oplLot0TFQTv7KxGLZxpXFMcIDhbiNbq0z8omx
         RkAQwRNiEsNi32obm8HShSlXgoATKSfNjgMzqFZrMxVrD64ONqdBLhqa4k0m1756VvJs
         2hSDHF9b4940DY0tbRwEhDTsJIToMlWY/hnsHcfwQ98bDBIlftCYZ+cRFQBHdLhY7FxL
         na5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765522950; x=1766127750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8J31nkKLMTJ/Qo0J4+PLRi2H/hsgHiES0A2U3TOlxM8=;
        b=GAUL0sSfTTnk9AVPzGYDTda+AHod1PHNZb8Cva6+M0iPJDKShuTHEYroEWX9BkC6U5
         xhmKW7Rhsrv55fuP0WDxIxu937b29axuv+yYmF9yN9FtG9La2/PM5X43r/W+XGvaFLR/
         yeGji8JvvetVSF/IqxzAal/N8Eg3v4Ik8cyLzc+uP9QgC48hzNp+5HAMwH0S6oy4g4QM
         GevHla/ImVAOjFrRxr0PufrUWge7ntZfT3pI6jASdRu9zCvH1Dx1GVXUQGELZRFoKNlb
         hQdep97hXhkJTyMdodXZrAyJbbHYRs/5KUqgQjpC7CTtp2+jupJDMqfVBaZYMSR3L6nV
         wesQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjgnUe9ZwhpFHuDCGwHjVLYOEsaGgFgTTDPbcn87F+m7MUakuYJjp/roF36aIYWdPLY7ckCXroLPVujFcH5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwixKAlrtW9Ck47d2qdvhekbzs+Lw9wReqp8GSzU5A+zYISYWIf
	p9Yunt7X6R4EmqmW//5Z8FBqO/oksJgROIO/BKGgTfQX1bW+VS7VmIZQRQwSdutTlWs=
X-Gm-Gg: AY/fxX5HG/8JLAKHz4HY0BdwmjrVJqrpuR37dm24COMW35LgBxIccmEwCBdI/CeewbM
	u80UvgqpC2N0ivxHjxnpBPeS7fVwoVXhdgtTD4shUnbf+ulv6xnf8L8xYZuFASrt7+53ksn7Awz
	Ivpakj670yngwpryUzOOPNiVuUWm3rDMDkizGr/lcCOuVvUAR25aK35e4czBe4DmhZhdHL4WgeC
	/eM8R6Kri9JyCalJ/q47JNxgBFdvxHwqYyWgbxgQjZ4EPeJjymL47qxuANGC0NREGKiLMwihnia
	kdQbODeuyea+LUIkZy1PvHlxpPkCrSCBZIQrHvoYRFhIXseM504HgsGIQVI9vHxZcJuXxWgSGSc
	2SucC+VKuhnQWodFEf3cxI51U1BsOYUlSRJFw6OKAWWF6dt2yRiIrDXZDMzR54dZvBcJgIeEvK5
	JBVw0pCqBUGFA9zRG6
X-Google-Smtp-Source: AGHT+IGAznv12+yx0m4z+hfisaKwl9TD4ly79IiQswuss6K34VrQ44sHBEHY9oPy8lOOyq9J3PK0JA==
X-Received: by 2002:a05:600c:1c91:b0:477:2f7c:314f with SMTP id 5b1f17b1804b1-47a8f8bdc58mr11091745e9.10.1765522949461;
        Thu, 11 Dec 2025 23:02:29 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b8a9efsm10976215f8f.33.2025.12.11.23.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 23:02:28 -0800 (PST)
Date: Fri, 12 Dec 2025 10:02:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Nam Cao <namcao@linutronix.de>, Yunseong Kim <ysk@kzalloc.com>,
	Nam Cao <nam.cao@linaro.org>, Tomas Glozar <tglozar@redhat.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Byungchul Park <byungchul@sk.com>, syzkaller@googlegroups.com,
	linux-rt-devel@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Question] Detecting Sleep-in-Atomic Context in PREEMPT_RT via
 RV (Runtime Verification) monitor rtapp:sleep
Message-ID: <aTu-Afezd9uXzDqr@stanley.mountain>
References: <32839fb6-dbcb-4c5c-9e3f-d46f27ae9a73@kzalloc.com>
 <87fraslu9c.fsf@yellow.woof>
 <87jyz5kuf2.fsf@yellow.woof>
 <20251202112644.YUux4LKd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202112644.YUux4LKd@linutronix.de>

On Tue, Dec 02, 2025 at 12:26:44PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-12-02 12:14:09 [+0100], Nam Cao wrote:
> > > RV is not a static checker, it is a run-time checker.
> > >
> > > Just in case you are not aware yet, there is also Smatch:
> > > https://github.com/error27/smatch. But I can't offer much help there.
> > 
> > I was looking up something unrelated, and I found that Smatch does
> > detect this sleep-in-atomic problem:
> > https://staticthinking.wordpress.com/2024/05/24/sleeping-in-atomic-warnings/
> > 
> > I'm not sure if its design takes PREEMPT_RT into consideration. But
> > seems worth having a look.
> 
> It does not look like it does. Judging from
> 	https://github.com/error27/smatch/blob/master/check_preempt_info.c
> 
> it increments the preempt-counter on preempt_disable() and spin_lock().
> So it won't yell at
> 	preempt_disable();
> 	spin_lock();
> 
> while CONFIG_DEBUG_ATOMIC_SLEEP would.

Yeah.  Sorry, I haven't updated this check for PREEMPT_RT.

There is a bug to do with cleanup.h that affects it as well.  If you
have a goto from inside a scoped guard that isn't handled correctly.
I need to fix that as well.

regards,
dan carpenter
