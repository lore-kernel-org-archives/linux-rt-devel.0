Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794519894;
	b=Ej2TGc+KW8NtDNtOIXS6DK4TzaKpb+kNKYbC65hj6kkEBVyrpVF2ZXm+umu3isBHKYuo
	 0FukXKMXADh1BYzWfRFLDJTh/StmSXZPPSA1HXlSJ08vl9aiWbdofoGiArIf7ucRHMuKl
	 dezQHB9c0h0W/1BecELkQRNWD60elMfrHanGxIYsTry4pQeEdN32EwX0z9TcSpWX44MrG
	 rv8gLabFe2Y3i6bfuJr/r9qftCNxKHiprZGbc1mSWKZUS7K7pgIc7GsnCip6bP/4H8FPH
	 Xb1l/EKLwg6svxftZkZ1n7KXnvA5ltX6xmmjzU+vaCWZoyv0eiHV7dmdrez5iGZ9CYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794519894;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3CSzqFHQTKbLxnAOVTodgLNTja/P3scXuEtCdPIGKVM=;
	b=MALof2jJa0aktLy9Xq7m7qNyGYOIBaEHiJ6eB7lggsdm3a3k4AEvdzXjeKcRomiCzHN7
	 16gwUTwKXEBhPdUXZGemdh2QmIibGU4MfH8HjunbTwnQ37hnvTV7UJzd4sHmCta/EFLiG
	 srO3Fz4uJFfCFlSy5LRxcS/rY+YIfXr+eUiIz0XKVPyk4ald4mMCRw04+a7ewR9C4fDIJ
	 yZYEQJgY71Y3pdDMSagqxTbLmsuvzr+l4Z+04ptcXTLM2ygNHsXlh/7priV0+KYD0B34H
	 0sIr5ImBcchUY2CLnvHS1RUxYDlo1O5M3UZptv9gP3hhlsRIPPJcJ445u59KBWMlFPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GzPHXgCt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090F4606A31C;
	Thu, 12 Nov 2026 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GzPHXgCt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF341F000C4;
	Thu, 12 Nov 2026 21:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794519893;
	bh=3CSzqFHQTKbLxnAOVTodgLNTja/P3scXuEtCdPIGKVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GzPHXgCtqMTAPKwTxtB6BR9vTwkNRKMmKqjyQ9w47suFXhMYbPsv9NPQOULIbvuoJ
	 Nly/5kQJ5Bx8Hlzc0qWs7JJDaFpsOVfALjIT5kCuwWhMKCFgnNC6FNsazycVaLnpku
	 J/yyumb1UXoH4r2I5HoAlNWjNeSGxyA26TuDYloNbhnoG9O+8GjseyZ7Vlzlgske9V
	 5VNpwSVzsZPFIm+Ee1cW0FZocN0mzujejgEndyhAtP4xLoR6G6wZq9HiTftSaTvTv1
	 TVr29VXgt7xpvRSDePx+T70833biCAdWUsDXv7Z8dVvoAn6JzPN/csYnmMsQN2tQ/w
	 2znNcg7OJ3EsA==
Date: Thu, 12 Nov 2026 14:44:47 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Nicolas Schier <nsc@kernel.org>, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Julian Braha <julianbraha@gmail.com>,
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/10] tools: Introduce a kernel configuration checker
Message-ID: <20261112214447.GG4107043@ax162>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <avQNdicGzL3De556@derry.ads.avm.de>
 <avWy2r1BcDatzwo1@lx-t490>
 <20261112175042.GD4107043@ax162>
 <avYQJiHwzCkzeONg@lx-t490>
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
In-Reply-To: <avYQJiHwzCkzeONg@lx-t490>

On Thu, Nov 12, 2026 at 08:14:46PM +0100, Ahmed S. Darwish wrote:
> On Thu, 12 Nov 2026, Nathan Chancellor wrote:
> > What tree(s) do you envision this initially landing in and taking
> > subsequent updates through?
> >
> 
> Unless you have any objections, I think kbuild would be the right tree ;)

No objections from me, I just wanted to make sure we were all on the
same page :)

-- 
Cheers,
Nathan
