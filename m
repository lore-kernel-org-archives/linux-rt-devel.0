Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229248;
	b=PHraUUec1GabiUUlNpLUOiww1sFvbFB+xlU9AMJXG647e+CgAfVYKu3ZbBYkU2MKJ8RE
	 8viApkIRyhCH6ClNcsvPooaBw76VV9A4V2E1kWp6fB39nMJgT4QYaeyoYxZScND5Lb2To
	 VLBmSaIiP8lwWYGWhovhaujIGWgfA8LC/pmhJkoSaO35TLqHXGTzpAcJIFAspTSzz6N0c
	 3UrY1d24Ma8/N/35fxaLwFLQP/K5ttiD49E8qNlHMvDilTDuatb+97XmoOHKxQpovIDvx
	 Wi0GAhVAW5MVoz2605Mp7z/DFjWS6sHSjU6MCns7GY/jTuIB/8jLuxctM+qP6g2OhVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229248;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=WH6vONAUZCDa/nrW45QhpFZ/1YVe1V2n6dO6VBPl2/U=;
	b=FFaqwSoEaFakGa+z1AiTVXmeY29FUbj0xDdfU6kgwYouyINLTP7L2Rg2pJqDc5qq1gnJ
	 I0zqQVQ6/pv9tMImRX8WynwDTeTBE7GxtSs27R6CL0eZu6cSl/9+smOQmg1YLTig+YGS9
	 eVUTYIO40htWOHxfuuM4+20q5Zx8tBhTeEaiJxDOMuOtHaMXBz4SMz6No2AJA6AFH51KE
	 9AWIO4k+ovguQpFYxxzO8obdTBI/ZiggY5HSJdqreNHflHXoKG7Nu+oPpcihGMj6YtQGT
	 pOFXTXC9TbWvGbM7sPxh9WmqZnhDLLjZcP8WaP58pn+7T4NShoxBLlWoQ2LNC+sLzxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=antO0PN7;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="U2zhFn/d";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E0D606A322
	for <linux-rt-devel@lists.linux.dev>; Mon,  9 Nov 2026 13:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2E0D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=antO0PN7;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=U2zhFn/d
Date: Mon, 9 Nov 2026 14:00:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794229245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WH6vONAUZCDa/nrW45QhpFZ/1YVe1V2n6dO6VBPl2/U=;
	b=antO0PN74enTHsEQP8fXrva5841B8kYJm3f/8g4WiNUDMEHnkHrqQcbV16doRVkV6t0nGR
	wNbTi7RkTZGvikTR/Oprvgns5g1GVnTcSe6Sszl7a5/AE5a7aPnmmrzQQ4HFULeaC80aCD
	bgYPqLN6S9hgtHUS5f6LN7lTHKm6zQIsouUUe3TziYVQkdH8LYSWLOifz3k4G1lUramJF3
	4CnWQp3ATGFR0ewBicGlPeEcgjtByezao9+8/oKoK7Ppf/+Lx9aK4YomdAnV6tD4ZQmZRk
	X0kJGfXk45h+K4kf0z1VV31B8pt+7qWLKiVaqKZb4vFqKxPkCp3TW4XrlznalQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794229245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WH6vONAUZCDa/nrW45QhpFZ/1YVe1V2n6dO6VBPl2/U=;
	b=U2zhFn/dp4n9V/CkFWblCRclJtuI2mdyDqWDdZOArcG8iZM6Fkc/RpReGQJQ+HEPA9SfQq
	IxbL4o8rbuu2EMAQ==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Julian Braha <julianbraha@gmail.com>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	John Ogness <john.ogness@linutronix.de>,
	Derek Barbosa <debarbos@redhat.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@amutable.com>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	linux-rt-devel@lists.linux.dev, debian-kernel@lists.debian.org,
	linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, arighi@nvidia.com
Subject: Re: [PATCH v1 03/10] kconfig-checker: Add the configuration checker
 code
Message-ID: <avHD-3JwbQofpJdH@lx-t490>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <20261106091922.7560-4-darwi@linutronix.de>
 <9729a4c6-22f9-4102-b62f-c76a75488240@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9729a4c6-22f9-4102-b62f-c76a75488240@gmail.com>

On Sun, 08 Nov 2026, Julian Braha wrote:
>
> On 11/6/26 09:19, Ahmed S. Darwish wrote:
> > +
> > +class KernelConfig:
> > +    """.config file parser"""
...
> > +
> > +    def _parse_symbols(self) -> dict[str, str]:
> > +        """Extract CONFIG_* symbol assignments from .config"""
> > +        symbol_set = re.compile(r'^(CONFIG_[A-Za-z0-9_]+)=([ym])$')
> > +        symbol_unset = re.compile(r'^# (CONFIG_[A-Za-z0-9_]+) is not set$')
>
> What does this do for Kconfig's int, hex, and string options?
>

So far, the tool only supports stating whether an option is enabled,
disabled, or have a neutral 'allowed' policy.

But there's nothing stopping us from supporting something like:

- name: CONFIG_PANIC_TIMEOUT
  expected: int
  expected_value: 10

- name: CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE
  expected: hex
  expected_value: 0x1

- name: CONFIG_NLS_DEFAULT
  expected: string
  expected_value: "utf-8"

In v2 of this series, I'll make the schema explicitly versioned.  This way,
new features like the above can be cleanly added.

P.S.,  I can definitely implement such support, but I'm a bit hesitant to
adding features that are not yet needed by the existing mainline policies.

Thanks!

--
Ahmed S. Darwish
Linutronix GmbH
