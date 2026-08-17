Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626243B47D3;
	Mon, 17 Aug 2026 07:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786953097; cv=none; b=cbAMsrTY3B1RrzK4Ptv8aLDWNPVUITcWfFkmKQfmjbzRHftylLhqAOCiLgtr2hCtq/TpTWRygJWyZBSVP2D/n4mycEycQhhKgnxj0Ih+70IbnxKXe7Pqo6LVryRtwKqEzX+p/KbR3P1fjCJCNJXmIUiFwWLtEe9t64NRSHaEoX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786953097; c=relaxed/simple;
	bh=O+CAeIVB74GBvtv5/pKVXvFbYpUE8lRMOSYNuWtk/QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ms9rNhaLP+el1TekNnOkw3YAUahvWx5y5MyqUhH3mSM7Ozmra+fTNZA9xBvudvKb0A9BElyhmuuNGxmEut/C7pXyfEaRBZjEajNCzc7/AJbW9Et+AcNHmPqQxqXyqjRkfO27nr3OMxcfvybnYXuDygN4bX40BwhrNvb5sdEfXc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NU90Nc47; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NU90Nc47"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258EA1F000E9;
	Mon, 17 Aug 2026 07:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786953096;
	bh=5ZYQOAJ6LqVx/y2pX8CakYIeDZQAZDDnBuPRyOAH8pA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NU90Nc47IvDFoPD8YQ2vm1Bt10nUJvfBqtw/JxNTOLs5Qo4wB9UIk7hEGlbBqyXnL
	 73+ujLyrJY5Q+a97d1uqQ9A0TcickJgoQfLDET/Bb9g8k+iEYG3K2CXYiRgzPTWQFI
	 kidOAkkBOSuGLN96qzuxgeWKD4w3oDAN8j1jwIkXxOn2Olyp7k8YvnCe9YE5o2PQf2
	 m4sh1891AiQScZ9yGUNNxLbo79qSre2ixAV9ukGQsw3PYIh4RtxospXMkbmvtbJWZ/
	 GP8fsuq6jJ8CJLsqf5Sewb766Jbm4k7+WOh3yR7/GRJh9lIyq2wPkPMNSRTx0kJ24D
	 tJgqHFFSiBeTA==
Date: Mon, 17 Aug 2026 09:51:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, 
	Borislav Petkov <bp@suse.de>, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 1/7] dt-bindings: edac: aspeed: Add AST2700 SDRAM EDAC
Message-ID: <20260817-origami-chicken-of-popularity-6f205c@quoll>
References: <20260812-edac-v1-0-03992edea297@aspeedtech.com>
 <20260812-edac-v1-1-03992edea297@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260812-edac-v1-1-03992edea297@aspeedtech.com>

On Wed, Aug 12, 2026 at 01:48:25PM +0800, Ryan Chen wrote:
> Add the "aspeed,ast2700-sdram-edac" compatible and note DDR5 support.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml         | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

