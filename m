Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CAB2BDC17;
	Wed, 16 Jul 2025 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752695989; cv=none; b=IRCD1awPhGID8tXX09hVyKCX3ijsaxTUmPuQdCURNr/D4fK7lFPuXvpPMDKrrndvycc+3OYS2qsUoY8owFjYBW1BUH5wcIFooDRQlPqn18PjmWIAJua1xYMBnV/vjH8qtFH7wIAs3tEgzR2XuStzLcMZEGlG4C87ltXcCfQmhlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752695989; c=relaxed/simple;
	bh=+JAJF1XNsDiacnVLeELmyTnWm99mVDlUIfSnTj/uvjc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kQ+Z8QBiVTD398ZZBtQXEyJulCaSi1ymuKIhfMX3yYUqnlIdzSXyrKcWdyNHCNVUuJMk7Fca8koSeKyClPB5oY/KJwKLKwaGU0nr1ksX/xRNzqdWWhy3g1LZ0sAPUaUL5wXDFi02cAcbSTtrRyv6Pfr5QWbqtIt0+Kqd9nklGc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFdViYkS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFdViYkS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BE1C4CEE7;
	Wed, 16 Jul 2025 19:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752695989;
	bh=+JAJF1XNsDiacnVLeELmyTnWm99mVDlUIfSnTj/uvjc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GFdViYkSuLoRUMTYiOFSqY8rc6UVxPIp8TgwDy0SveAt8ltXaOAtxmoxwuuX68gtx
	 L276evSqEEuLhWXOcVzZi8z2psPD3ZG8wjzO/BIKztWW0MPmyN0jwblEc3kko+W5Q8
	 xBCH//BDG5JUYxf1XpRI7L5WZcWJDCGzXcrdo5WH5EGFkabQct27NcOlMj3j3SOGmv
	 P82NeJACbhD8rrw8PcNsGgUqfYVx7W26AevEsU7/iq5AhdrsQU7UwjV0PQMFzkpjM8
	 5b7RSm2CIJx4QBw+lUjGLvVDG1qHlAPTbMsM+3Suqyd0PgFxJgEtYcu7CESV3AEni6
	 6uToJtiiXhrMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BC2383BA3A;
	Wed, 16 Jul 2025 20:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: Enable interrupt during exception handling
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175269600935.1308944.5530274266993935851.git-patchwork-notify@kernel.org>
Date: Wed, 16 Jul 2025 20:00:09 +0000
References: <20250625085630.3649485-1-namcao@linutronix.de>
In-Reply-To: <20250625085630.3649485-1-namcao@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 peterz@infradead.org, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@dabbelt.com>:

On Wed, 25 Jun 2025 10:56:30 +0200 you wrote:
> force_sig_fault() takes a spinlock, which is a sleeping lock with
> CONFIG_PREEMPT_RT=y. However, exception handling calls force_sig_fault()
> with interrupt disabled, causing a sleeping in atomic context warning.
> 
> This can be reproduced using userspace programs such as:
>     int main() { asm ("ebreak"); }
> or
>     int main() { asm ("unimp"); }
> 
> [...]

Here is the summary with links:
  - [v2] riscv: Enable interrupt during exception handling
    https://git.kernel.org/riscv/c/969f028bf2c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


