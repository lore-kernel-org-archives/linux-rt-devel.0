Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6224D296BC8;
	Thu,  8 Oct 2026 22:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791497816; cv=none; b=fKI2KsqRSEEvS+KZsUk8vAWWMc5od8FvFD59ViqUZQ5FWOthiNmrQ6KsS5zLJkP5EGwylZW8Dvdf3OBSI83Nb9uugXd3CIT6w5EoPiHZK/olXvURRgFfiFaHqkcSfmAyJpT516ih52Xq2QiDIBOZaEL3mEXXzAB1GdL7o5sWxKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791497816; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R88eL9u0JGJ36eSCV+kueXVwA/bUjtQJmVUHW6tiQfiZpkPBEMwsOnzfCDTv1n/gBCA38uIB08pjrfC5lQZUw5B7i6ibLqpRSACGGR34Trds04IEXd8EUGe8txF5AL1cHx3AfUpLL6gN7OIL16esoSYU+xUSUTm4eJ/ufCZ1r9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCIiqzUe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCIiqzUe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BCD51F000FF;
	Thu,  8 Oct 2026 22:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791497814;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RCIiqzUeKie7E2b+mqPyO4SJwFzJ59o82zuNMMjB3eNi99HPUASSqo4THpusAZy6T
	 wWZlYD/GAYymaG/E2tVjsjoF/St5JzupeSP9fX7xT+cEvXwjRzZaKHPB7ImDGNZSBi
	 cNUTXuDARm3eF4BYCFso1VGDudcpz0fvqoPSBILJz/fKjuwbQx6pCUlOVUw+RvkOX8
	 p96Q/peepyLx+s6JpFj/QSrnhL6qVcSEUKa75/nxspj/fQyyoZyLFrAHSIhdac7ewO
	 o9gKS7NlFFq89QLfN6aGaEGLLKd65wwXgL68i6WMQE73MA9BFfkUAKhziE3t5gmx20
	 6G+/i7Aw3wHEw==
From: netdev-bot+sinfo@kernel.org
To: Joseph Kain <jkain@nuro.ai>
Cc: netdev@vger.kernel.org, edumazet@kernel.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net v2] net: do not let defer_count outlive an empty defer_list
Date: Thu, 08 Oct 2026 22:16:53 +0000
Message-ID: <179149781385.2527009.3611488194198236417@kernel.org>
In-Reply-To: <20261008220256.1844072-1-jkain@nuro.ai>
References: <20261008220256.1844072-1-jkain@nuro.ai>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
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
