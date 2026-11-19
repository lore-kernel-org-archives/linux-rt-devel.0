Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081321;
	b=cShMA658uaUB2CeXZ0Q4UymBX+eRt18ML0QQsv1npqghLG2GWCBwzVNG4g8zMD5yWc+S
	 Ob9ASTwADjGiRwyOuqrsqXRPNGg3qyFOTpbioabHT8G0+NJNzWLaDbibCeVGAKMC6/x2O
	 knYWaGNPdCiyn3oZoyIPdbX2tic1nBO6Juecx6p++ZegUgOrAJxeFXS/0GemsBG4394mr
	 rvhgPPdJBdPQ0gEri4IM3feZmfBArq4j/Lw5nSZ4vAePYyjo2HBPPCoVaHUa9yWhF1JzJ
	 HImhIkwN0tnCRqxNtIFpjRyiWII8WrRXbNR41nY4uJQHTTcaTDMHuC7kY/4Oraw1zuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081321;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Uwqp7Bz8a5D3/B2xkBHbhP2Bh4hQYQFs0RxyAqY1Gn8=;
	b=XXhoztHuNYdPFrZXBJq5vO9ct0hL6+kiCcV9b/3JY1RGV2VPle4LjMMSmT8G7VqpUB7G
	 rfSpUEx2hacmCVr83nTa3e1IO+aEpSlIxKmmiEc26Z2ZcfDD3naurAh3qcRj8ayWGmroB
	 IuESPV1oMxS2f80uKs4RkLKG/tw7fSiEiMPLo6NYLlkYF+fQED4WDNwIbISm/2zLDCnsa
	 1y3ggKrkZBQboAPOmAjKJoMSDJQciL/QEVwQheJGSrTcFyfa2A/D4AXQo+a0pVpmtar6B
	 9rIvoC81qzIvj53W2FifpMGlAQC2MV9395SpUXxFtwTkRBqF5YJu6iBVZ9P++oVOCOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZvFWTe4U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC374606A320;
	Thu, 19 Nov 2026 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZvFWTe4U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC86B1F000C4;
	Thu, 19 Nov 2026 09:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795081320;
	bh=Uwqp7Bz8a5D3/B2xkBHbhP2Bh4hQYQFs0RxyAqY1Gn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZvFWTe4U8C6+0/DOn3h4TunkDgDufnWIlpxx0NPx5BH23ol7iDGDxp68AhWxgSrq+
	 bVOdvsyODfZ/xe/LcwaIw2F0gY2PjV7ullhDNWXHKpodMU3rVn6oAoiOTs1N22qBvw
	 JFAO9RiW3jKcdWoGdTfSP24SHKTKNEU6orVyhNHTvWoUb4BwPcxt1KeDHvk9uUppmI
	 5qZO6OFbkiOOAe6Wpkseh/A20QDQHHmz4QTA4d0ud1t7Wmhryw/rEWVrQm6lJFRFLR
	 pxfX3SjoV77b6bwEwvjNj9z65gngki2mONP9yIrcjBCD8dzP1A2b5vCSdbP8Kp2mON
	 v98TzVGjsWi0w==
From: netdev-bot+sinfo@kernel.org
To: Haoran Wang <wanghr2026@mail.zgclab.edu.cn>
Cc: David Laight <david.laight.linux@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, rostedt@goodmis.org
Subject: 
 Re: [PATCH net v5] libcxgb: use raw_cpu_ptr() in ppm_get_cpu_entries()
Date: Thu, 19 Nov 2026 09:41:59 +0000
Message-ID: <179508131937.3291.4712022842119294003@kernel.org>
In-Reply-To: <179508121445.22600.6953098503196332718@mail.zgclab.edu.cn>
References: <179508121445.22600.6953098503196332718@mail.zgclab.edu.cn>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
