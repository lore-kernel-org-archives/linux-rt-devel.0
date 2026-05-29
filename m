Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41623D1A97
	for <linux-rt-devel@lists.linux.dev>; Fri, 29 May 2026 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780071711; cv=none; b=MNpjLJxoo5b+rvjb7Dj3gDM1W1KxZ7HAyGOyg2ScbS3YolQx7TwwTUmpmGAeMvIvH2hlVQdRIfPCuqAbiaJ8RLM70IYKYnpfujjckEZLTxfNZ4thQIcO8QV4MZJ16w9G+1a2+ThnpU0ksii7+wkfQjkrq4PpBYxBL4WsEAGYa0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780071711; c=relaxed/simple;
	bh=G+zh2PeW4L5nDuAFsU//uPDTdR81r0tDlQPCUy9QAbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C4Jdhpers6T5nnXOHpELhxv7P4UqePsyJkYrB7ZEJKp23WvMpd+JHlQ8stah5vkLx7l1ZykhCcUBLP2xDfDgzbDa67qw/n1JsQXxnpiGe8VwyXPys2l3M69XJ3hOtF0nkitxQeHly64pncpi7eJh0hqN8sTQgcQpl50wmBblbZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=JC1R/k9C; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="JC1R/k9C"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-304d0ac5e3cso858345eec.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 29 May 2026 09:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1780071710; x=1780676510; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JsOIMq9FwgDH9PGuBTd8VWOVeGL7jgAx6IFRF0AXCuQ=;
        b=JC1R/k9CfBuidXyLefEW+NrOkCMnztvwQ6ax8EpVpVaFT8Ad8rDfSR6ayB/SE/lW9X
         x+4sJ+E6r854j+9wLMo4tpUpNy/eXagTbqUxqB1Y+pu0vqSfBGilvCv8sU8se933Htt5
         iRWcdKQoXkB7Joh5Mm732bf4B0QlhI0EF2zA4vNI/fgUALtwy6LEj9bWOABuKSJCUSR7
         PUYJvFDVgD6OXNa8xX259xzHP2xMmE2+As6xxVLET1l6x65yGRKi7QifHXisU3WJ+9mP
         B8ofVUsKOd4+ffGcwL6NpzZbNpP9OVHL2ibw2y4bZOcwN+YSzOGFmvE7uFd4kTuMJsPO
         XqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780071710; x=1780676510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsOIMq9FwgDH9PGuBTd8VWOVeGL7jgAx6IFRF0AXCuQ=;
        b=AuMCR2Dt9QjcSMY+ZPl49hWHMuiGd49Gh0BqJ2Stqd42BMJXIwuvCBalnB71rEKz8t
         xhe/1IAtre2O3yyWpi9vRg2blnB6lmkxRk4CMDuMZnFj9WhOU05lB1HkPFcBeUGaIOAY
         lwxB1oYjfuWQGMrKcE5IyauuQv4xP5kX42ezhPstoc2KxrnpYKTsjv9twDRV+4TcTujv
         etLEnVOl73ve0pRZPPxnVTf3zAN2lAIfZIF7p+Tb31mbAdZM9KBJ2fqO1pRD2nXQgqRU
         /FSIvZkNTQmlHqcD+XTZlAtDkvYF6PI4R25WawsxxDKe6k3IHWwDEZibftpEngya2xKC
         u5NQ==
X-Gm-Message-State: AOJu0YxcJiEsAFznXe8U+o2ZfT3nUSLOQBmH/ESrpvYf0U1s8kOhvmVi
	RQtrgIQmDUkEFPL+YsDNnQZpS5OCs3h0LNBeuEcAjrUic8fHt6c5ufr8wxr5pAcmtrg=
X-Gm-Gg: Acq92OELQWZjtOhx5jI+BaPCC/g3NApGl/H+3rfDyRXdFiNjTdvhS335snJrQ/OHx3g
	CoZz0QQIwaYIF0eYVkVUoqE0QDEpI6kNhu4+cS8eWd5R7HVpnNePd1Kx5/m4IsjDig6eR80k4aG
	wV3JiRj/S1uBPhE7XqbH2wJ7UEIqgjOES3kdKDbByJ+27dGyxk8pXDI2zRD2NONz53ZmWdZD9AK
	UeJ4fpkPaiDpq/pfLUM1yGJuU7RAnB7VDD3scvCKEGQ63qZU5XhkJV7iV9jhFbf7jxw0fzGzD+o
	FawMpJBSVvNNfTzMA9yoJ2oQsoMHRhRZN9RknXv+XPo1af11mUW3kdIH8NednbAh8EUWKlZiwAH
	G1JkyTeBwpbbNFnOjqephTV2XUIpEFBtkurheu+e9b+7JQmCbvBshwCxU2E+ehe9iRqM/UeZStT
	Z+JZhsbBUqANWxyeYOCfYC5cnwMTH2pLUTnjsN
X-Received: by 2002:a05:7301:2926:b0:304:630d:e4c4 with SMTP id 5a478bee46e88-304fa573c64mr248605eec.10.1780071709273;
        Fri, 29 May 2026 09:21:49 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:2bb2:ae86:9dbf:b82e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed53f316sm1718902eec.19.2026.05.29.09.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 09:21:48 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
	Rodolfo Giometti <giometti@enneenne.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] pps: Don't try to wait for negative timeouts in PPS_FETCH
Date: Fri, 29 May 2026 09:21:43 -0700
Message-ID: <b5241c09ac0dfb82ee076d06367ac6319471c773.1780071212.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If userspace passes a negative timeout to PPS_FETCH, it triggers a
kernel splat from schedule_timeout():

    schedule_timeout: wrong timeout value fffffffffff0bfb4
    CPU: 17 UID: 0 PID: 4720 Comm: a.out Not tainted 7.1.0-rc5-x86-kvm-00150-g331d97e36b37 #1 PREEMPT_RT
    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-20240910_120124-localhost 04/01/2014
    Call Trace:
     <TASK>
     dump_stack_lvl+0x4b/0x70
     schedule_timeout+0xb7/0xe0
     pps_cdev_pps_fetch.isra.0+0x93/0x150
     pps_cdev_ioctl+0x70/0x310
     __x64_sys_ioctl+0x7b/0xc0
     do_syscall_64+0xb6/0xfc0
     entry_SYSCALL_64_after_hwframe+0x4b/0x53

Sashiko imagines this to be some sort of security problem, which is
obviously really silly. But I think it is still worth fixing, so buggy
userspace code can't trigger the splat.

Silence the splat by skipping the wait if the ticks count is negative.
The current behavior is to return -ETIMEDOUT in that case, so keep that
return value in case any userspace code might rely on it.

Fixes: eae9d2ba0cfc ("LinuxPPS: core support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/cover.1779733602.git.calvin%40wbinvd.org?part=3
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 drivers/pps/pps.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index de1122bb69ea..6755901fbdae 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -65,17 +65,19 @@ static int pps_cdev_pps_fetch(struct pps_device *pps, struct pps_fdata *fdata)
 	if (fdata->timeout.flags & PPS_TIME_INVALID)
 		err = wait_event_interruptible(pps->queue,
 				ev != pps->last_ev);
 	else {
-		unsigned long ticks;
+		long ticks;
 
 		dev_dbg(&pps->dev, "timeout %lld.%09d\n",
 				(long long) fdata->timeout.sec,
 				fdata->timeout.nsec);
 		ticks = fdata->timeout.sec * HZ;
 		ticks += fdata->timeout.nsec / (NSEC_PER_SEC / HZ);
 
-		if (ticks != 0) {
+		if (ticks < 0) {
+			return -ETIMEDOUT;
+		} else if (ticks > 0) {
 			err = wait_event_interruptible_timeout(
 					pps->queue,
 					ev != pps->last_ev,
 					ticks);
-- 
2.47.3

