Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795252088;
	b=aZW5NWditmdauQkB5gi83/0pyx05QjJw/A570Ug8Z/btr7/5VQ6LajQAsafzx+woux8J
	 PhsL54Ip8q+QYc+USrqFgbNUB6w5BF+SWKPWGBtFjQtJn1MovA3M1/7N8/0SOsWJbtTmD
	 WU6z2ks1qQX8nUeKgZvQRMC3scKC2V3yInMlFX5tDDDdePfUtLOfzYwt7Y4tSoEbsJrj3
	 vz8lZMRDn3yllls9dcUw8e/A88pgICfzUJpX7XD7Skj1XhGSHtZoUO77wml1HObdHxikg
	 YIC+dU2ng9/Ev2dP72nY3RFA61QPHqSVvYjnEnxNZzfB5N/n7Qu2qZ0e0H2XlUhFwaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795252088;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=v/KSonE9ptOXxsuc9pp4torUv+e/nHP0QcHgDnUNcJU=;
	b=fxSnXhTs1NYF6TGsF7etknGfAYjJKqXkDKV4zdbDySsxM+qStUkA2F2ImmHJpJTGKWM8
	 GgkOLBpn2Vvy3FboWjsXyBKkuzFeA5qjQ44vN21F3OyIANDOM05kblJne2lGKQJXaeN2/
	 rVi+H87okMAH79rhowlZkpi+w0z8k0Ghr4hMf1WgD18Dsg/wA5mvCSFm3FUDkXBbAlYAR
	 DqgMttlwB4dxszdO5+tZuuU1cl0aE6du8lIKbvdmWymyoEm9XhRWkUJ/bH6QBzjCktHVg
	 80vHbKb6jotEoNQJXEz7lznKjq0vjgURO0DAHOl5PGM0zEKQLJ6vUBfrsWFkkO4eLYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cxv4eaCp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FFB606A320;
	Sat, 21 Nov 2026 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cxv4eaCp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B563B1F000C0;
	Sat, 21 Nov 2026 09:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795252087;
	bh=v/KSonE9ptOXxsuc9pp4torUv+e/nHP0QcHgDnUNcJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cxv4eaCpbXRq6+v7J1sHTC/XE2qAAtLQj83KoTTDZefr9jTQzjqRiqZh4HC71E79v
	 Vlt8Av7KJ7IrypkZtZ1Cn9eiJuRAAf6TGWckhX742luMP83OZydl05emuuerW4iGFi
	 bFOSua99qcr/sduVAr5VNWinteptSmxaZPzwlnyor2FHbFTbclSF0DHjxJ9g11cBGV
	 8YBV7YlXxwhF0fR8e6yXSTtoxEUtc/ysgrmo8r7TaXZq+/r3cToH+fHVRKC523F5Y2
	 YRDhDq614icNC0D1dMZrkIXCdTNckyawppSsihWKW3aNBEgG5dMD9FE/rzxkoB1lhv
	 WIf3Bn9VA77Aw==
Date: Sat, 21 Nov 2026 10:08:04 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, Richard Genoud <richard.genoud@bootlin.com>, 
	Boris Brezillon <bbrezillon@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, 
	Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v11 23/26] dt-bindings: mtd: sunxi: require the H616 AHB
 reset
Message-ID: <20261121-active-pudu-of-flowers-ddfa8b@quoll>
References: <20261120-submit-sunxi-nand-vendor-oob-layout-v1-v11-0-9721b1905ef4@gmail.com>
 <20261120-submit-sunxi-nand-vendor-oob-layout-v1-v11-23-9721b1905ef4@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261120-submit-sunxi-nand-vendor-oob-layout-v1-v11-23-9721b1905ef4@gmail.com>

On Fri, Nov 20, 2026 at 06:10:46PM -0700, James Hilliard wrote:
> Normal NAND reads and writes worked on H616. Fault injection exposed a
> failure when recovering from an aborted internal DMA transfer: the
> controller's soft reset could leave the first subsequent read displaced,
> sometimes without an ECC error. This was not observed during ordinary
> I/O.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

