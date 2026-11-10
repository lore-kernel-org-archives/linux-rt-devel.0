Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794301373;
	b=pS+3uvOs9MSjj1B7ZiVKOslhQE7leW8IX6q/BuLVjAGybF/m7nvETG/b1Qz5GKIFH2Fr
	 BW1hWKWg8IYE1QTPA+/Vq3D/suebkZaePGooaJPPkCnRu5nmIZhrtVzA4PWmv/otIJ1i0
	 QdDc91gO3x/3+BNvgBbssceePf93IJJ7WeJYO3g+J4ypf5Nd6CM2CtnLQ6jTAYs3VkHK3
	 BcGRiZK/h2bL61LJwUl/8qmpaF0suv3lAcK5pYM4tVO5q9rP6leZzhIahTyPWs6ND//EA
	 KEcSWZzvL43LxScJx8y3e52WGwfEigaoHGxCacGe+k2aKO0RlwPbnZ8fzg5lDDfpU0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794301373;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=MmOhc84eWQQaLrq1Z+Ju5XLUW5n0u5y21GLBneQbQiyPC3R9BuXpqhznpD6oMFyAenl1
	 ZPAj8ilpNTyZDFGKS60D6HZZGie6bTr3mvMOK24tRc+7PmZcIcbMNZWCK6uSTRgngWWUd
	 0cVez3yE809m/H6+xswxzFJPCGFMbiEC+d1l+GL4XOYVpFZbyn3uSq082khUWTdOiByiP
	 xlnAArurNa3Euc5jwYDDpS5IczUvGF3dd8sKQVLzGBM4pvqdKScQQMcgTRndmQNgBUWee
	 vMX2XITuO13N6PilVJb+EhrLh+zcRNtN1BT7OCrOVG5FV4IVv6owgL528o8dX/YnzLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T1919nph;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F345B606A31C;
	Tue, 10 Nov 2026 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T1919nph
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED40B1F0089F;
	Tue, 10 Nov 2026 09:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794301372;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T1919nph2VQzl15ak/14R9C8DWKuvENBONyo7TbK7TC9GkShDyuhHnXvNya+Yga4S
	 Hx6yBrekeNmF/bIE2OAw24yRPrKepdf0yu2dWkETezmGuACYxqT8R25Di9tk2FqV0r
	 QpK/pE6TilsKB7Wk5TD8qwqHQfM6LZjtbViPV8IPID5zEPQNusXSIzXyW+5QDQc/rB
	 jQVyCPXkA3f2n2Yq6LhF5b4Nxp+RtJP23jvP8DYRq/eTynEQIuXpu5C8t6BHjsHoqC
	 Y3RebmEAs/hyS8H5eD09/5aD7I+nVV50dftSL7s8+lOkWPCBU48g3vFs0vkm63ZN3c
	 TBV2PH6JFAMqA==
From: netdev-bot+sinfo@kernel.org
To: Haoran Wang <haoranwangsec@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, rostedt@goodmis.org
Subject: Re: [PATCH v4] libcxgb: use raw_cpu_ptr() in ppm_get_cpu_entries()
Date: Tue, 10 Nov 2026 09:02:51 +0000
Message-ID: <179430137148.488859.15630804371226096686@kernel.org>
In-Reply-To: <20261110165742.1204-1-haoranwangsec@gmail.com>
References: <179241614797.5916.13928836073297916808@whr>
 <CANZ3JQQrrntu0TefPZC79pKSmsOfwAngRJyuaVm81DYaJNFHFQ@mail.gmail.com>
 <20261109180748.33682-1-haoranwangsec@gmail.com>
 <20261109200332.52e2fc0e@pumpkin>
 <20261110165742.1204-1-haoranwangsec@gmail.com>
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

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
