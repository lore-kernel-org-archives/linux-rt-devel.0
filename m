Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793953159;
	b=qyOiJ8bVwQV9lSA9YcNpBdAQS1RvrX7v9ZXb7Zgu9P6+JgAkHGNysUBmaqQn05AiWpRk
	 Lm+hVT6kD7iMWf77BmEoRQaWZL15K7n+aFn1p1+8qcb7g2CPlR+c8DLNjUesJFX84l44M
	 zbpDrXeCzbMwijC0qhjRKeE6K2Jsyuhab0BYw0oJAdRaNyCDfRsONaR8CE/tq2wDmh9CM
	 w4dKaUC2rWaAMdEr5BBQ7tNfunKUbnwrKEv3/y35dXn+ubX0NE3q//BbyAw/SA1OFzsVv
	 GDkPLMAr5HJJMSh8fp3srK9Ehrs8J423Z6LMPJAJe88e7aMH/ThgGJlmavNH23mkglA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953159;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HCgag2Z7bBQB20jwuxyYaKHOlG23BLLiKfiDNoXW0NU=;
	b=O9MpcjSEXwCLSgbdlT3bd08hoTiYgV8kebnqWVOjM6OtaNIckQN8ormuGMC5/W9QUmCH
	 r/+ahmDmW7Ix9m6hzEUKQC+lr/tD1eTPro2wnozg+gr789wuYlfI802fGY08xNIg9x8vw
	 mL9IxiIPHLzv0iPZ4QQieVUn1YaAr8GOpxYaTOv6/g9g+rCMNRe/iPRGnOo3mT+7qfzNr
	 c+n7IJueEtpasvxzqevbya/453AtjgtF4MIq1mdbJvc4v16gM7aP4mHll5+0VE6jA8IXZ
	 2QbNJONAG3amnk9j4lpcEFhNmXRlMqsNvSPjThg4EdjnjayH0EJaSH2klABJI0KZdhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k9L+w4Jw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D93606A326;
	Fri,  6 Nov 2026 08:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k9L+w4Jw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295561F0089F;
	Fri,  6 Nov 2026 08:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793953158;
	bh=HCgag2Z7bBQB20jwuxyYaKHOlG23BLLiKfiDNoXW0NU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k9L+w4JwTo3DlQ/DiUpLeG/F+/3PMGfxKf+cVssmryL365e3yme/kMXMH1gtSJzgH
	 Z8ieCyRotm3HSx5uje7KDgs2Zq9BOwXLae51mimR7Gi94aZtVXQA9QFdXeP9QbhXib
	 6FJ6WAhWhayBN0WlNrWNNctuhfXGhEeriw/IooSXw5hGN2UiQWyYjyZp0B1vn4zt5t
	 Pq+Q/0qqsXeonXj2ehTWPs25HSEsWromhWWlkTdgTwqbarNzMhUS2MH5trgGnHJ3dT
	 Jt5tWJZWpVX08rBuvF89JYrH0i4yqjnr7VZLnrlC66NU3aHtX9b07y3eId5w5uasP3
	 ks0atxnzcHevQ==
Date: Fri, 6 Nov 2026 09:19:15 +0100
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
Subject: Re: [PATCH v10 20/26] dt-bindings: mtd: sunxi: require the H616 AHB
 reset
Message-ID: <20261106-crystal-flat-caracara-ac1b3c@quoll>
References: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-0-dca1f6ed29a8@gmail.com>
 <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-20-dca1f6ed29a8@gmail.com>
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
In-Reply-To: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-20-dca1f6ed29a8@gmail.com>

On Thu, Nov 05, 2026 at 11:55:36AM -0700, James Hilliard wrote:
> The H616 NAND controller needs its AHB reset to stop internal DMA and

So was the device working or not? Be explicit, because this is an ABI
break.

Best regards,
Krzysztof

