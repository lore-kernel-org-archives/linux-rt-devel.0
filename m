Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794219116;
	b=iKlNW+1nOPdc49KD+76YloOxZUAL2Hfp4eBG+1vkrb2ph3AxuA044js0v5QN92S4rBi9
	 jd1OvNQYi7lq0+lOME0MS7qKc54Zo+DOm93T8mJzXAN0r0dcdyb/PUQNeGQEG9b+1u7lX
	 6Td95HGKB0WZcgv3cD7D2lMHQvLm/NpbpbLF3NSmXt788eds9VqR88tnHkvS11IliB2iI
	 QeW94q+8fb1H+87tYFW2CmUEepCCsgIjZ7tdgAM/aNrO5qQL18tsPHyon5yYJY6BMxWcW
	 urdnEfSFYBO2H9N870PttWoIFjXiYdU/67pFD/JP4qIC3hIp7mn6rl8NQ1LBUQ9Do1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794219116;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=4PwPTYvUP8V42YbkL0aFsnILtNcKmPoDeS2PVM+NXli693KJ3EFYZpPz+8SSuYGDVTuI
	 t/vUZx0+PIiQP+an2FH21iUGRzHEpA4dcRvm+25Q7hqrBduEIq7I4kpMFd+/VQriRKL3A
	 MnHJaaqyZjNU4qdkfSd2uOCUbDvfOSsq2VDTewspmaeLV9wVo8EK8VvUOyqiShXBLg3gq
	 NkxuqKR1zXn+25c24oFdPx5nl0rWtUcbTfh3Yacd+tHQLGaoB81qdxLQixnBK5Dg/vkrJ
	 8vUAQanrEHS8ahNsQhybJSCcZ2DCXHm7T5IpPutPpk9Ft0S7M+QZkPqA40p6aVAOy5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cTQbNglF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E5F606A326;
	Mon,  9 Nov 2026 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cTQbNglF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28171F008A2;
	Mon,  9 Nov 2026 10:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794219115;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cTQbNglFLxd7CnGj6CHJ6jXVjDlh2gAp0hDfuk7/oIinE6L8mYTqlzRVjTUKZUPTs
	 hEVJPTIxRcOHndaAV6BATfzenEHE2etMAaBEc/l4QQPvcFHfUR95GWDBRKYf3VhsuX
	 NQwh+xjXuVGY8DuN+7EMal9srZD/IQYAJKshg+SftZvlR1ujl5GtTG1oScORWVQRB3
	 WDaUh4fA2WLULFUieDbB8V74S4Lm8nHwtJLInrtRMrboEHT7noIOlizSCbqclqvYCw
	 PnJ0kB7r4OWLdk5Wjdb3wfKfQn+kU7V4On1aCT+Y3ULcfdziGtxDPKwIv2CzwJkygz
	 muMPSSyL1Pliw==
From: netdev-bot+sinfo@kernel.org
To: Haoran Wang <haoranwangsec@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, rostedt@goodmis.org
Subject: Re: [PATCH v3] libcxgb: use raw_cpu_ptr() in ppm_get_cpu_entries()
Date: Mon, 09 Nov 2026 10:11:54 +0000
Message-ID: <179421911425.488859.14833625973296276572@kernel.org>
In-Reply-To: <20261109180748.33682-1-haoranwangsec@gmail.com>
References: <179241614797.5916.13928836073297916808@whr>
 <CANZ3JQQrrntu0TefPZC79pKSmsOfwAngRJyuaVm81DYaJNFHFQ@mail.gmail.com>
 <20261109180748.33682-1-haoranwangsec@gmail.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
