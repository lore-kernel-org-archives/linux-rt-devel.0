Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F173C1974
	for <linux-rt-devel@lists.linux.dev>; Wed, 22 Jul 2026 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784712710; cv=none; b=aWBwtt//1ZLkfE1XOPsIiXyJRLGwW9BUUVBAqMq6DHYxImkzRUYbZR2RmdpV8eDfbTDvNSAjbAt6t4PpLJ0wgrkYH3kP8WngaAeS2HcwuCAjvUciYJP50V7ILNx9yTUiEzpyC5Tk2rJaR8k1jeVBCJA0PI6Z4x6/CoVBn/Ru0hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784712710; c=relaxed/simple;
	bh=FCSWly/X4vb4JjmvLMDZdGpBNdJfE+KvXCPFhwEso6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pdTDbEsQy/vWCaonBYCNA0JkLYzpKwta+s/nhKdmEcLzep3CcpXaqN1Z3V+n6RHZI/mUeaYFRflc3qPPjivy07vY3TNaBwdT86sI2FPu6AojbvGaS/m+65VYgFrkSgFz/yK5DHbQpBXugMxAgJBSEC5IRw1DX3cNQhzd1I+phm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GHhVTwXE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Iiqh8L2+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GHhVTwXE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Iiqh8L2+"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784712705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U9gwoYlY25YZ+Zs/BNuUi3uSABuYSthk1Hlidh/LUDY=;
	b=GHhVTwXE3/dJBK7grEMgGsJL6PvbBsT7oLgD77O0wc1V8IdE/kBfQd7wKgt1kLZ0vvj9ub
	mwq3OmxURgNkyA2x58NMs9uXZZlSJEv6BCSHgc6hu/l9x0K7h8cdkQzjKYuZ591B1dABOm
	MWMV7MLhihN7EfXe0hwTzN3xH7DgdLbv/2fJSKMLmcMgsW4gDnV4oVityGsEE+vFBH5mki
	ygkdT0YInP5LzS1fzVlDB4CZUL++p/tomj/cZvC+FZxsZ90+62MB1rJQDep6MvDnP6NFJH
	M9MCY9raBcd72oCbvkK5JGfTjGujvWNoP7xV8w5eejirsWAMXPL8wmcO5rlDng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784712705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U9gwoYlY25YZ+Zs/BNuUi3uSABuYSthk1Hlidh/LUDY=;
	b=Iiqh8L2+FPsWWXjEyy0HncRcIBQM093QhaZ59vZkXjXpXKVwOLHW1izJJBPeJu0mrluXSa
	xlyV8Mu9ya39RiBQ==
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
Subject: [PATCH net-next v3 0/3] af_unix: Fix priority inversion issue
Date: Wed, 22 Jul 2026 11:31:33 +0200
Message-ID: <cover.1784712370.git.namcao@linutronix.de>
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

v3:
  - Move unix_schedule_gc() to be after exit_task_work()

v2:
  - Add patch [1/3]
  - Rebase the other two patches onto the new patch
  - Change commit message to be more precise

Nam Cao (3):
  af_unix: Schedule the garbage collector at task exit
  af_unix: Do not wait for garbage collector in sendmsg()
  af_unix: Clean up unix_schedule_gc()

 include/net/af_unix.h |  5 +++++
 kernel/exit.c         |  7 +++++++
 net/unix/af_unix.c    |  2 +-
 net/unix/af_unix.h    |  1 -
 net/unix/garbage.c    | 16 +---------------
 5 files changed, 14 insertions(+), 17 deletions(-)

--=20
2.47.3

