Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5693F2C027F
	for <linux-rt-devel@lists.linux.dev>; Tue,  4 Aug 2026 06:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785825993; cv=none; b=Tn3IyR5ernhLhOJnpt7fW9s289/295MPnDX0oAtNul2HmhTNb/wwZAzJUJzsm6feS6ph4R8w6499kggVBTAjcFbV3EGO3GfO4xYnhwy03BDIvI4SZOXME03WM5kDKw5gkMDncCOyhKRHYlow8rLJooHGLcBfe34HgkJoGptYiJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785825993; c=relaxed/simple;
	bh=jwS/oicCGPqZOlXjjrcyNCk7ylSsbNI1+gdW3igR5ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B8uWGHwrRZiYfKLSI+98SPtZLdeToT3tG2koXBv0zrXwL5deE33Cdx6DhYT6/1SywxMKcK3CKVfDhrlq5ySyFKYon5Md0C/5447AUZyx+pcMxWgor6Boo1I11k8OoXjZYC1sKUDJj1Hwa9mdNpmJcryqTRz/mZFYtW45+0OiNGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B8/Ncx8r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gHxZQUfS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B8/Ncx8r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gHxZQUfS"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785825990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f/zxf51PdYNDajR+SbMsBEC24rn1nWHLdyjfToDBFAg=;
	b=B8/Ncx8r69/+TJeNvEz2Gg4CSquS5Z5B2luh+bynYAPRAPdC4iz+xA4a32ptltd3U17A1i
	yIvQlz7hlXir/dAOiteQKmTlkO4tKXAWD+XFgxXjCYG7q4DGIsn/UwxaVw7O3W7I//OD74
	ySOBfJuW5n1icVfz5BWmunhHKk30sXFiBBFmYZe+MYLt0fHuCWQPssIwBKDpKQYsdJ3+F/
	HIU7Z2SX68PWeQdogceGOy9/t6sgH3o6ukKlINWbdZH10wvWDJ/oQzwCflrNpsIH/0fxry
	TZc/uoAdngVYZB7oRBD4ccRbLrWeCWZj9+Tbr4t+KR2i2+rpyyUY3dAhhi/82Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785825990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f/zxf51PdYNDajR+SbMsBEC24rn1nWHLdyjfToDBFAg=;
	b=gHxZQUfSlh1DnyouPXaV918QEi+yE+TaZUbRWtBTCbepqKPay6oOCQfSVzv7PPRyyRhJr3
	1qUBlltl4sWDZxCg==
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
Subject: [PATCH net-next v4 0/1] af_unix: Fix priority inversion issue
Date: Tue,  4 Aug 2026 08:46:15 +0200
Message-ID: <cover.1785824313.git.namcao@linutronix.de>
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

v4:
  - Downsize this series to just removing the priority
    inversion. Garbage collector scheduling should still be cleaned up,
    but that is non-trivial and I do not want that to stand in the way
    of this simple fix.

v3:
  - Move unix_schedule_gc() to be after exit_task_work()

v2:
  - Add patch [1/3]
  - Rebase the other two patches onto the new patch
  - Change commit message to be more precise

Nam Cao (1):
  af_unix: Do not wait for garbage collector in sendmsg()

 net/unix/garbage.c | 3 ---
 1 file changed, 3 deletions(-)

--=20
2.47.3

