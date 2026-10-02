Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAAC3233E8;
	Fri,  2 Oct 2026 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790970839; cv=none; b=dkUkT7xdLVWgD3I8o18G5C28S77tfnHWjzMkFAf3skIDCm7j5PgVxB269D5R5ikHC5CLHnqcqiM3Gv6kPIzPJrdrjsv0/HFHP9/EmJK8YamEH2fctjGubddj8syLtZLGsUFr+c1re8OH11lMxVNqahKyI5zhdeS9dhFekoGZGCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790970839; c=relaxed/simple;
	bh=9tOb7DIcnqsRM8TxYYLyzFNKoTYr7ziFvNs0pX884eA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dwh9mZdwAuFC7VMh/LdJkCuYDr9Azoaf+IBdBL8RhcCzowyiEmr3hhZ83FWPg7zfH2EgsihL0Qiyjahf7kHGjwoBGhmTdhQqB7G+V7c+VsqXDg5/NqZSJTCopKObq+p9s4llIWAxn8aJ9oPOLjK6M4laSVXL/N+/O12Li24Muqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwnIB+Vr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwnIB+Vr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B4D1F000FF;
	Fri,  2 Oct 2026 19:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790970838;
	bh=9tOb7DIcnqsRM8TxYYLyzFNKoTYr7ziFvNs0pX884eA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kwnIB+VrZUUrNooZ0h8N2ocI/aPcWplWPWHXgVj8GLaSSWe40oqOLAk9cmbfFT6Q5
	 gpPTIsQXC2cD/C/wLUHeb9jTwt/W4YoFvdsQ9Y60oAYvoztYylS4eKLXk+9432WKrv
	 W1vLUFHRkn6YBnBacd3v6IKw62STTrwpS6qqMfDf+FOpzRYz4uSmRmTAjgRKZtTLG9
	 EvGN3ngJax80uasBLX90EbqlgwbL0PT02jHyStoOV99FhIve9VzNXeWv+hrYNX0sgz
	 EuffkQgi6pRThPsdAisdVk+BlZ5JbkgxyQhQFSugG+UXYVST4fPvphEia2H7CmVRG7
	 wrpSUaRSdFsfg==
Date: Fri, 2 Oct 2026 12:53:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev, Nam Cao
 <namcao@linutronix.de>, Kuniyuki Iwashima <kuniyu@google.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v5] af_unix: Do not wait for garbage collector
 in sendmsg()
Message-ID: <20261002125357.200a5aeb@kernel.org>
In-Reply-To: <20260930162457.4ajVJ-Qa@linutronix.de>
References: <20260930162457.4ajVJ-Qa@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 18:24:57 +0200 Sebastian Andrzej Siewior wrote:
> From: Nam Cao <namcao@linutronix.de>

This looks effectively identical to v4. I'll put it into 'Needs ACK'.
If Kuniyuki is unconvinced please do not repost this again.
