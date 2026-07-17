Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F131E3264D1
	for <linux-rt-devel@lists.linux.dev>; Fri, 17 Jul 2026 06:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784269648; cv=none; b=aYGxR2+VyeVg9dpazfs50udlspS+czGHnvJL6pFjbaAReQ3B/IKTbT+R5mT2y+yORBh8Wu6+3kcF7wRw2Z8CUb8YTvhQudhCpGYmCAZ9XdaZHZrrd0FxYaMUgfMTEjMs12iWscE7ckSFPYQAB5Gks/33qK/X9ekL/20ehuoX2CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784269648; c=relaxed/simple;
	bh=BKPpIwApMeRwTWfwyNaBSdqS3csESpAA3BeAqRcxhoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fvyWnajZkNlB492IPL5hgr3aiI/5bxv7GgTaUdCK/K4LZcHI/WjbCTieLqC48wDcJOUnAlxnCP7uASfgFVNrZmwXJYY2aavmlPIPjlwteqcyDAnp3KaXBeBKPoPX7AdmtX65atr3ixcRmj96qdz4iDtogQt6MIZjLik3DlBFmxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N2zPa2c9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OjGMMvNF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N2zPa2c9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OjGMMvNF"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784269645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uSV17cNUOcdylJi5Mf1fbtYe6gZxAY+CsDtcprPu/7s=;
	b=N2zPa2c9yvfLqpDyMSOKZqC0YrCEn+wEc6h5USdaQ/9khE9Jk19wgKfUx9EZpStp70g/Lj
	HDkvAtrsg2k/JokRUixriTeBIv2958YwNm37s8INIDIJ87vkT7ory33ygIFhBQcNs5oUxu
	hqKfsJzhfvuMxlN1l/XRC7V1Crrp6tWVfDUUo2lH537+teZNp5YMjFCr0229j7BPdY4deu
	/1FWTsjQfIUkE12eX0yyi611vOUKCtkyT7A1pFvTsDSZP5VGYTB6fejjof65sCko4JHsyV
	liqHdzzZDH8YoDqWsGmutkYHs2p6S7SCum2a4syO9Gl+EYll9ySOI1DBjNiEDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784269645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uSV17cNUOcdylJi5Mf1fbtYe6gZxAY+CsDtcprPu/7s=;
	b=OjGMMvNFiy2Jy6lf31EzmWCuU6qqqHQqcY+/eYCU+hcDJB1IGsTAZ+UgsWaCX4a2smrBpR
	rymqLZ3pxcraQ2Bg==
To: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH net-next v2 0/3] af_unix: Fix priority inversion issue
Date: Fri, 17 Jul 2026 08:27:14 +0200
Message-ID: <cover.1784268931.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

While auditing AF_UNIX sockets, I noticed that the sendmsg() code paths may
block on the garbage collector running as workqueue. This can cause
priority inversion and latency for real-time users.

The implementation does kindly avoid blocking "sane users". However, it is
impossible to tell whether the kernel's definition of "sane users"
accurately describes all users out there.

Digging into history and figuring out the reasons why sendmsg() needs to
wait for garbage collector, it is determined that those reasons no longer
apply.

The first patch resolves another issue reported by Sashiko in v1, paves the
way for the second patch to remove the block. The last one is a simple
post-cleanup.

v2:
  - Add patch [1/3]
  - Rebase the other two patches onto the new patch
  - Change commit message to be more precise

Nam Cao (3):
  af_unix: Schedule the garbage collector at task exit
  af_unix: Do not wait for garbage collector in sendmsg()
  af_unix: Clean up unix_schedule_gc()

 include/net/af_unix.h |  5 +++++
 kernel/exit.c         |  2 ++
 net/unix/af_unix.c    |  2 +-
 net/unix/af_unix.h    |  1 -
 net/unix/garbage.c    | 16 +---------------
 5 files changed, 9 insertions(+), 17 deletions(-)

--=20
2.47.3

