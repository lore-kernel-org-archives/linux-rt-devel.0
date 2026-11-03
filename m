Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698159;
	b=FqwyW/A7tEOg0k8LVoqYyxWfRks6ZSUpRUP9X1JlNa5oa0YYey1oZ57e0jT0emJ6blVG
	 XPDkppQRWuDiDHW5Vs4718U9P1IxjQFAQl2VBQYzHjDqWQUiQ/I5zU4WRZU8aTKdMboRv
	 5/yy+P/beqn13mUJzcgmBOLWqkezKTbG/P1lpSGHdbE5o6HGAcorn+xh5oQN6GvOP7g9D
	 /N5hzk7DFBkGc7uciwMngZk+TkMIX7T8CDz/avUlz3UiK0sGZ/FlHzG/SVv5syuvFo8IF
	 Jit0FuxOms0zpo62f/RrGxhnL8IrUkEPcq+h30zNdt3dWhxlCU2fHKuuiXq99SJxRyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698159;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=0hJB4np+uuLZHMP+UWPtPpYoKMuEppTk4AxvaZ282uv3cJLi3mEgAowoYTqowbx+6DrO
	 VD3aJasaeOCELNok+Dg4FhRdk26/wm/yFTHe/NfXLYqez59JG/2bdkTUWVqoq32NoKo0l
	 tOguA625btiguJ1BH3E0rcV6teiBALWC5oMXS1v1qiBj5iW1UbpJ5Amj1uoFg7lzvuXM8
	 hJKxFap8fs6VDCkx2EqKXd2QUdcnjYjsHbF5BH3VatmtY/f1IElR9t8PaMQYC/CgM4Lf7
	 hcDFWeA3/G0wo77OQO2IxvSoWAbcMBaVg7JYrZ854knHejFM6Y3WLHmxCkKLCW+UGzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QU4J5/fX";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355BF606A331;
	Tue,  3 Nov 2026 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QU4J5/fX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A691F00919;
	Tue,  3 Nov 2026 09:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793698158;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QU4J5/fXIDFS01d1TPv30qxnnYDMSS9Uz9LtwKdt+tO4VuP0KC58PZwY2MWHNL3z5
	 Agi3ohvB95zwolK/JDi5kWvDD9LBNhSahSoGVHaG4Og4PVw3eJaoI6f/3bUuxSIW1u
	 mxvsLap0/xdoyij3khSDv2MQ/obyM2n8y3gYFuzPUpS7xjCROctTnGD8nrQAr7FMRg
	 XvWGtNfzIDVsBvpVMf5qBzHb44J04VTJGbKa5o3HSoG6mMBY19RKQbAC8l4TQCsdwl
	 mM1sYk3gNhcM3iJGzsKggabJDcXxU7sWjuoK00HDty9EvTFH/227+w20BTcCLaFNr4
	 8/rBs9WjUGqdg==
From: netdev-bot+sinfo@kernel.org
To: Jingxuan Xie <jingxuanxie@deeproute.ai>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 John Ogness <john.ogness@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [RFC PATCH net v3 0/1] af_packet: avoid waiting for TPACKET_V3
 copies at retirement
Date: Tue, 03 Nov 2026 09:29:17 +0000
Message-ID: <179369815762.488859.15460471694371846273@kernel.org>
In-Reply-To: <20261103092541.273847-1-jingxuanxie@deeproute.ai>
References: <20261103092541.273847-1-jingxuanxie@deeproute.ai>
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
