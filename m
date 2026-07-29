Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781AF2BDC2F
	for <linux-rt-devel@lists.linux.dev>; Wed, 29 Jul 2026 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323382; cv=none; b=Jd543s2PAXf5pFOeRPZLZ+YIyXv17Bg7mJfnO9peZXuc1/l2Dnk9t1Fuc1aEhcXo3si9j2ii6efdmDwtZt58bD0et6cHOmWfwmpGRkNFQqRSuO4gD7VXBksDOtOrmVA2zthJZoAHz84BO2pAg+t6cHVOuaHnRb5aLV5bU24vd4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323382; c=relaxed/simple;
	bh=tRD9Hnc+FiDzMwa7ooASAfjCm420hLC7sETJ7IsQPtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=li+UP54nfAGftS+jQgBGyXoyxdi6Pph5Zuia5vc3QzpJ4pLDrfHByat63TddKSUF1CxOEIpJBdQiWwniWJyZDZCfRPPREsmIbkdlzcXqlNtDjH41uC6SdPn6xs3TpGhOyBn5sjU08Brz7GJR3om9vKTZsmto+2mirrFghaAfoUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Yf7gRuGM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Yf7gRuGM"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so3944245e9.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 29 Jul 2026 04:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785323379; x=1785928179; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1mrR0h5a2tnzaiN6M63ThlKTtbHhhDFOkDL005+wWy0=;
        b=Yf7gRuGMJLb18a6k6Uyz+3fHet7KNQ7PtDJMKNSfG0fFLmkwtTG9ZA6wtUrxTfIi/s
         t0KwcRYEtA3Zb42+Hcl0zFAvuNr08XvgwfcD08Q03mYCu1Vo17f7JclcOc55ZYVTXOW7
         UnJDyWUPoGguK9WoJBCsmE0Sq5B7dXbMIwwEKpPj7F4mhZ1pAput0ZCAp+30n9YUCX39
         z6ng8i/exmt9qoRRY7AcPkynupGqBKymabEiydaZkLPQBbuD3yZdHQeTG75y7VmHLKLe
         NglSB0nmrIl/YGwwB1KiAfY9xidOMsInul9vAPLEzOpYkvLEHOb1CjGqc6LvZ8vSD78v
         Ajxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785323379; x=1785928179;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1mrR0h5a2tnzaiN6M63ThlKTtbHhhDFOkDL005+wWy0=;
        b=IjGbc4yRtPsiE8GXOtfrpb4/LlzvFLdxNsAym00RwK3jO8beV2M84CQ4EOUmuVRsZe
         5/rJnEdKYQmy9TQTrtolJp3zngb5YJ8/SdtCdb8w5bWRdV0F68dT1mlVWlUmJ0U8Eq2E
         ENKcTYArIgIlq7M6xY1NoV2K+dyWkH+pFejNmlkkJdoQhqQQfL0fedBeKRRY+K1VILbn
         P17jbeMXvyUr2NAkipvdA29uDS9yHqXu2VFmlc6ly+l0kI7ukp7udOBTtsjnSjrzySui
         04wTkraqyBTRSTmrWkrcUhY2U7AydgFmiegtNl7ogyiAoi3ctiy7pHgY+JYx8R6wHwdr
         MD0Q==
X-Forwarded-Encrypted: i=1; AHgh+RrdDuUnq+2p5omB+Kk+iFnTSaT3uKD2jBColM6i1ug30+FwU0BGKBQFvtRP/x81lt1yvrfZGBRa6oQupMXLqQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YykgJRn5y7WRsqqeTRDDXKsubAQUifrs/V5tNER38LF6Ivp3ME4
	YF0qZ/hp3o+g2l7uKXRJP/rPedc+QxbtDKI0mho7Z2nzFrz4jwM91WOZUJIbbk4SsBc=
X-Gm-Gg: AR+sD13lMXJvS38k7lOfivFhMLVqp31ek9GJlQ0TffL79jUy2O7uFa6cp++Ru9N9WrL
	4itjirPwx65/FAhUH4fJL0dKgK3pVDCvPiUf8TgpbzBA+2du9Pshk4fJoYwXiMZXC1Y+xLvb17u
	En5aM2c/7OdCNnH5NpKu+6Zhvm4RUX/36iRGyYLh0CHuohjahFj6QbLQJ1uVP+mbi39v9Yg63DT
	p06wtyPzOdczR3l2VzWomqnFlppBVgPfW3BhRxvsBFInmuuub0+hcB7m6BnqAL9kp8DwLqumrGE
	7DtgQYiqyIL/kvg/01MUV4lWZ86mzdjjLgOee1rMpqsqT8DHc4pXXvK/ifmoaOHV7HT5AmVuN5m
	7fQ0NuZQDoE27wqX79JNEi1MhpahgXEQ97t/5tg9cLEtvv+pCVHZrDCiTyEGBm6/RAK0s/um0uu
	v+wYF2oGUdrZoCZgByDHIzvP97oC4PFwKMub4SX63RkAv+Itkl3MciuN8iS+2eMgs=
X-Received: by 2002:a05:600c:3b13:b0:495:5890:8f6c with SMTP id 5b1f17b1804b1-496c653d3dcmr82110535e9.7.1785323378759;
        Wed, 29 Jul 2026 04:09:38 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4976bd7c4c2sm50189635e9.14.2026.07.29.04.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 04:09:38 -0700 (PDT)
Date: Wed, 29 Jul 2026 13:09:36 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>,
	'Karl Mehltretter' <kmehltretter@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <clrkwllms@kernel.org>
Subject: Re: [PATCH v2 2/2] serial: amba-pl011: keep console clock enabled
 for atomic writes
Message-ID: <amnfcOod6ayqfNda@pathway.suse.cz>
References: <20260724213348.77418-1-kmehltretter@gmail.com>
 <20260724213348.77418-3-kmehltretter@gmail.com>
 <TYXPR01MB15199DA567AF4541DD79359FBD7CC2@TYXPR01MB15199.jpnprd01.prod.outlook.com>
 <87pl0863t5.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pl0863t5.fsf@jogness.linutronix.de>

On Mon 2026-07-27 14:05:50, John Ogness wrote:
> Hi Toshiyuki,
> 
> On 2026-07-27, "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com> wrote:
> > Regarding Petr's comment [1] as well, I'm concerned about the
> > potential impact when the clk remains enabled during periods without
> > console output.
> 
> Can you elaborate on your concerns? Do you actually need such low-power
> _and_ kernel logging directly on serial?

Good point!

> > When creating nbcon patch, I saw a similar patch [2] from the past.
> > Have you considered coordinating with the clk subsystem implementation
> > for this?
> 
> AFAICT there was no real justification for enabling clocks per write
> other than because we can. A lot has changed since 2013 and neither
> spin_locks nor raw_spin_locks are appropriate because atomic printing
> can occur in _any_ context (including NMI's).
> 
> If the amba-pl011 insists on enabling clocks per write, I would
> recommend not implementing the write_atomic() callback. Since I assume a
> significant amount of users _will_ want atomic printing support, perhaps
> you can add a Kconfig to toggle building with clock-disabling and no
> atomic, or clock-always-on and atomic.
> 
> Note that there is also CON_NBCON_ATOMIC_UNSAFE available, if the driver
> wants to somehow blindly enable clocks on panic in order to unsafely
> dump panic logs.

I personally vote for removing the enable_clock()/disable_clock()
from the console->write_*() callbacks. It was an interesting power
optimization. But I believe that the chance to see kernel messages
in critical situations is more important.

Also I guess that the serial port is _not_ used on devices powered
by baterry in production. It might be used when debugging and
it is exatly the situation where the messages are important.

Best Regards,
Petr

> John Ogness
> 
> > [1] https://lore.kernel.org/all/al4KdsU9YLOmwDoV@pathway.suse.cz/
> > [2] https://lore.kernel.org/all/1359475526-17523-1-git-send-email-walimisdev@gmail.com/
